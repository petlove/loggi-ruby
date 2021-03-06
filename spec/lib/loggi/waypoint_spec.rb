# frozen_string_literal: true

RSpec.describe Loggi::Waypoint, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.instructions).to be_nil
        expect(subject.index).to be_nil
        expect(subject.index_display).to be_nil
        expect(subject.eta).to be_nil
        expect(subject.leg_distance).to be_nil
        expect(subject.address_st).to be_nil
        expect(subject.address_number).to be_nil
        expect(subject.address_complement).to be_nil
      end
    end

    context 'with options' do
      let(:options) do
        {
          instructions: 'Entregar pedido de Client Xyz, cobrar R$ 10.00 com cartão de débito. (Deixar pedido na escada)',
          index: 1,
          index_display: 'B',
          eta: 1_561_234_918,
          leg_distance: 2225,
          address_st: 'Rua Sansão Alves dos Santos',
          address_number: '200',
          address_complement: '8o andar'
        }
      end

      it 'should full all fields' do
        expect(subject.instructions).to eq('Entregar pedido de Client Xyz, cobrar R$ 10.00 com cartão de débito. (Deixar pedido na escada)')
        expect(subject.index).to eq(1)
        expect(subject.index_display).to eq('B')
        expect(subject.eta).to eq(1_561_234_918)
        expect(subject.leg_distance).to eq(2225)
        expect(subject.address_st).to eq('Rua Sansão Alves dos Santos')
        expect(subject.address_number).to eq('200')
        expect(subject.address_complement).to eq('8o andar')
      end
    end
  end
end
