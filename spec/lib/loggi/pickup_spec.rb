# frozen_string_literal: true

RSpec.describe Loggi::Pickup, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.address).to be_nil
      end
    end

    context 'with options' do
      let(:address) { build :address }
      let(:options) { { address: address } }

      it 'should full all fields' do
        expect(subject.address).to eq(address)
      end
    end
  end
end
