# frozen_string_literal: true

RSpec.describe Loggi::Dimension, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.width).to be_nil
        expect(subject.height).to be_nil
        expect(subject.length).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { width: 10, height: 11, length: 12 } }

      it 'should full all fields' do
        expect(subject.width).to eq(10)
        expect(subject.height).to eq(11)
        expect(subject.length).to eq(12)
      end
    end
  end
end
