# frozen_string_literal: true

RSpec.describe Loggi::Pickup, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.instructions).to be_nil
        expect(subject.address).to be_nil
      end
    end

    context 'with options' do
      context 'with nested models' do
        let(:address) { build :address }
        let(:options) { { address: address, instructions: 'Pegar no balcão' } }

        it 'should full all fields' do
          expect(subject.instructions).to eq('Pegar no balcão')
          expect(subject.address).to eq(address)
        end
      end

      context 'with hash' do
        let(:options) do
          {
            address: {
              pos: '{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }',
              addressSt: 'Rua Augusta',
              addressData: '{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consolação", "short_name": "Consolação", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "São Paulo", "short_name": "São Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "São Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consolação, São Paulo - SP, Brazil", "types": ["street_address"]}',
              lat: -23.5516433,
              lng: -46.6516703,
              formatted_address: 'R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil',
              complement: '8o andar'
            },
            instructions: 'Pegar no balcão'
          }
        end

        it 'should full all fields' do
          expect(subject.instructions).to eq('Pegar no balcão')
          expect(subject.address).to be_a(Loggi::Address)
        end
      end
    end
  end
end
