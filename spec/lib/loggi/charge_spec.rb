# frozen_string_literal: true

RSpec.describe Loggi::Charge, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.value).to be_nil
        expect(subject.method).to be_nil
        expect(subject.change).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { value: 10, method: 2, change: 5 } }

      it 'should full all fields' do
        expect(subject.value).to eq(10)
        expect(subject.method).to eq(2)
        expect(subject.change).to eq(5)
      end
    end
  end

  describe '#description' do
    subject { build(:charge).description }

    it 'should be a Cartão de débito' do
      is_expected.to eq('Cartão de débito')
    end
  end
end
