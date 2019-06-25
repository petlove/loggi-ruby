# frozen_string_literal: true

RSpec.describe Loggi::Services::PackageHistory, type: :model do
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
    subject { build(:services_package_history).query }

    let(:template) do
      <<-QUERY
        query {
          packageHistory(packageId: 231814) {
            signatureUrl
            signedByName
            statuses {
              status
              statusDisplay
              detailedStatusDisplay
              statusCode
              updated
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
    subject { build(:services_package_history).login_required? }

    it 'should be login required' do
      is_expected.to be_truthy
    end
  end

  describe '#request!' do
    before { authenticate! }
    subject { build(:services_package_history).request! }

    it 'should return packages', :vcr do
      expect(subject[:packageHistory]).not_to be_nil
    end
  end

  describe '#get' do
    before { authenticate! }
    subject { build(:services_package_history).get }

    it 'should return shops', :vcr do
      is_expected.to eq(
        signatureUrl: '',
        signedByName: nil,
        statuses: [
          {
            status: 'ns',
            statusDisplay: 'Não iniciada',
            detailedStatusDisplay: 'Agendado | Previsão de chegada: 19:49',
            statusCode: 1,
            updated: '2019-06-24 19:11:12.121141'
          }
        ]
      )
    end
  end
end
