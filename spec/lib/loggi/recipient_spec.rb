# frozen_string_literal: true

RSpec.describe Loggi::Recipient, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.name).to be_nil
        expect(subject.phone).to be_nil
      end
    end

    context 'with options' do
      let(:options) { { name: 'Client XYZ', phone: '1199678890' } }

      it 'should full all fields' do
        expect(subject.name).to eq('Client XYZ')
        expect(subject.phone).to eq('1199678890')
      end
    end
  end
end
