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

  describe '#request!' do
    subject { described_class.new(credential).request! }
    let(:credential) { build :credential }

    xit 'should return shops', :vcr do
      expect(subject[:allShops]).to be_a(Array)
    end
  end
end
