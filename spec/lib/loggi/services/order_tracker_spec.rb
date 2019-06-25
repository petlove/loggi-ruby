# frozen_string_literal: true

RSpec.describe Loggi::Services::OrderTracker, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.pk).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { pk: 17 } }

      it 'should full all fields' do
        expect(subject.pk).to eq(17)
      end
    end
  end

  describe '#query' do
    subject { build(:services_order_tracker).query }

    let(:template) do
      <<-QUERY
      query {
        retrieveOrderWithPk(orderPk: 97269) {
          status
          statusDisplay
          originalEta
          totalTime
          pricing {
            totalCm
          }
          packages {
            pk
            status
            statusCode
            statusCodeDisplay
            shareds {
              edges {
                node {
                  trackingUrl
                }
              }
            }
          }
          currentDriverPosition {
            lat
            lng
            currentWaypointIndex
            currentWaypointIndexDisplay
          }
        }
      }
      QUERY
    end

    it 'should be equal as a template' do
      expect(subject.squish).to eq(template.squish)
    end
  end

  describe '#login_required?' do
    subject { build(:services_order_tracker).login_required? }

    it 'should be login required' do
      is_expected.to be_truthy
    end
  end

  describe '#request!' do
    before { authenticate! }
    subject { build(:services_order_tracker).request! }

    it 'should return the tracking data', :vcr do
      expect(subject[:retrieveOrderWithPk]).not_to be_nil
    end
  end

  describe '#track!' do
    before { authenticate! }
    subject { build(:services_order_tracker).track! }

    it 'should return the tracking data', :vcr do
      is_expected.to eq(
        status: 'allocating',
        statusDisplay: 'Em alocação',
        originalEta: 2033,
        totalTime: nil,
        pricing: {
          totalCm: '8.90'
        },
        packages: [
          {
            pk: 231_814,
            status: 'allocating',
            statusCode: 1,
            statusCodeDisplay: 'Agendado',
            tracking_urls: ['loggi.com/c/D4qcua9r/', 'loggi.com/c/62xpHC25/'],
            shareds: {
              edges: [
                {
                  node: {
                    trackingUrl: 'loggi.com/c/D4qcua9r/'
                  }
                },
                {
                  node: {
                    trackingUrl: 'loggi.com/c/62xpHC25/'
                  }
                }
              ]
            }
          }
        ],
        currentDriverPosition: nil
      )
    end
  end
end
