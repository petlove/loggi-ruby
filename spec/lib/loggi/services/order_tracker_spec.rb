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
            waypoint {
              addressComplement
              addressSt
              addressNumber
              addressData
            }
            pickupWaypoint {
              instructions
              index
              indexDisplay
              eta
              legDistance
              addressData
            }
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
            :pickupWaypoint=> {
              :instructions=>"Pegar no balcão",
              :index=>0,
              :indexDisplay=>"A",
              :eta=>1565964795,
              :legDistance=>0,
              :addressData=> "{\"geometry\": {\"location\": {\"lat\": -23.5986957, \"lng\": -46.685013}}, \"address_components\": [{\"long_name\": \"1155\", \"types\": [\"street_number\"], \"short_name\": \"1155\"}, {\"long_name\": \"Avenida Doutor Cardoso de Melo\", \"types\": [\"route\"], \"short_name\": \"Av. Dr. Cardoso de Melo\"}, {\"long_name\": \"Vila Ol\\u00edmpia\", \"types\": [\"political\", \"sublocality\", \"sublocality_level_1\"], \"short_name\": \"Vila Ol\\u00edmpia\"}, {\"long_name\": \"S\\u00e3o Paulo\", \"types\": [\"administrative_area_level_2\", \"political\"], \"short_name\": \"S\\u00e3o Paulo\"}, {\"long_name\": \"S\\u00e3o Paulo\", \"types\": [\"administrative_area_level_1\", \"political\"], \"short_name\": \"SP\"}, {\"long_name\": \"Brazil\", \"types\": [\"country\", \"political\"], \"short_name\": \"BR\"}, {\"long_name\": \"04548-004\", \"types\": [\"postal_code\"], \"short_name\": \"04548-004\"}], \"formatted_address\": \"Av. Dr. Cardoso de Melo, 1155 - Vila Ol\\u00edmpia, S\\u00e3o Paulo - SP, 04548-004, Brazil\"}"
            },
            :waypoint=> {
              :addressComplement=>"8o andar",
              :addressSt=>"Rua Sansão Alves dos Santos",
              :addressNumber=>"138",
              :addressData=> "{\"geometry\": {\"location\": {\"lat\": -23.6059493, \"lng\": -46.69458969999999}}, \"address_components\": [{\"long_name\": \"138\", \"short_name\": \"138\", \"types\": [\"street_number\"]}, {\"long_name\": \"Rua Sans\\u00e3o Alves dos Santos\", \"short_name\": \"R. Sans\\u00e3o Alves dos Santos\", \"types\": [\"route\"]}, {\"long_name\": \"Cidade Mon\\u00e7\\u00f5es\", \"short_name\": \"Cidade Mon\\u00e7\\u00f5es\", \"types\": [\"political\", \"sublocality\", \"sublocality_level_1\"]}, {\"long_name\": \"S\\u00e3o Paulo\", \"short_name\": \"S\\u00e3o Paulo\", \"types\": [\"administrative_area_level_2\", \"political\"]}, {\"long_name\": \"S\\u00e3o Paulo\", \"short_name\": \"SP\", \"types\": [\"administrative_area_level_1\", \"political\"]}, {\"long_name\": \"Brazil\", \"short_name\": \"BR\", \"types\": [\"country\", \"political\"]}, {\"long_name\": \"04571-090\", \"short_name\": \"04571-090\", \"types\": [\"postal_code\"]}], \"partial_match\": true, \"formatted_address\": \"R. Sans\\u00e3o Alves dos Santos, 138 - Cidade Mon\\u00e7\\u00f5es, S\\u00e3o Paulo - SP, 04571-090, Brazil\", \"types\": null}"
            },
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
