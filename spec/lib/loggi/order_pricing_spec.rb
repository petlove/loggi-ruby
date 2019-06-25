# frozen_string_literal: true

RSpec.describe Loggi::OrderPricing, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.total_cm).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { total_cm: '23.50' } }

      it 'should full all fields' do
        expect(subject.total_cm).to eq('23.50')
      end
    end
  end
end
