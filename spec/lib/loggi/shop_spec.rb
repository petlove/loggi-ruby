# frozen_string_literal: true

RSpec.describe Loggi::Shop, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.pk).to be_nil
        expect(subject.name).to be_nil
        expect(subject.pickup_instructions).to be_nil
        expect(subject.address).to be_nil
        expect(subject.charge_options).to be_nil
      end
    end

    context 'with options' do
      let(:options) do
        {
          name: 'Coelho Burguer',
          pickupInstructions: 'Retirar pacotes no balcão',
          pk: 129,
          address: {
            pos: '{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }',
            addressSt: 'Rua Augusta',
            addressData: '{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consolação", "short_name": "Consolação", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "São Paulo", "short_name": "São Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "São Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consolação, São Paulo - SP, Brazil", "types": ["street_address"]}'
          },
          chargeOptions: [
            { label: 'Cartão de Crédito' },
            { label: 'Cartão de Débito' },
            { label: 'Dinheiro com troco' },
            { label: 'Dinheiro sem troco' },
            { label: 'Máquina da loja' },
            { label: 'Cheque' },
            { label: 'Não há cobrança' },
            { label: 'Vale refeição VR' },
            { label: 'Vale refeição Sodexo' },
            { label: 'Vale refeição Alelo' },
            { label: 'Vale refeição Ticket' }
          ]
        }
      end

      it 'should full all fields' do
        expect(subject.pk).to eq(129)
        expect(subject.name).to eq('Coelho Burguer')
        expect(subject.pickup_instructions).to eq('Retirar pacotes no balcão')
        expect(subject.address).to be_a(Loggi::Address)
        expect(subject.charge_options.all? { |co| co.is_a?(Loggi::ChargeOption) }).to be_truthy
      end
    end
  end
end
