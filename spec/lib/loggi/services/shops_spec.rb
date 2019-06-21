# frozen_string_literal: true

RSpec.describe Loggi::Services::Shops, type: :model do
  describe '#query' do
    subject { described_class.new(credential).query }

    let(:credential) { build :credential }
    let(:template) do
      <<-QUERY
        query {
          allShops {
            edges {
              node {
                name
                pickupInstructions
                pk
                address {
                  pos
                  addressSt
                  addressData
                }
                chargeOptions {
                  label
                }
              }
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
    subject { described_class.new(nil).login_required? }

    it 'should be login required' do
      is_expected.to be_truthy
    end
  end

  describe '#request!' do
    before { authenticate! }
    subject { described_class.new.request! }

    it 'should return shops', :vcr do
      expect(subject[:allShops]).not_to be_nil
    end
  end

  describe '#list' do
    before { authenticate! }
    subject { described_class.list }

    it 'should return shops', :vcr do
      expect(subject.all? { |s| s.is_a?(Loggi::Shop) }).to be_truthy
    end
  end
end
