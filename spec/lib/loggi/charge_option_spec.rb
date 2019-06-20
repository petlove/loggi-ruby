# frozen_string_literal: true

RSpec.describe Loggi::ChargeOption, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.label).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { label: 'Cartão de Crédito' } }

      it 'should full all fields' do
        expect(subject.label).to eq('Cartão de Crédito')
      end
    end
  end
end
