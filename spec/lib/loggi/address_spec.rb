# frozen_string_literal: true

RSpec.describe Loggi::Address, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.pos).to be_nil
        expect(subject.address_st).to be_nil
        expect(subject.address_data).to be_nil
        expect(subject.lat).to be_nil
        expect(subject.lng).to be_nil
        expect(subject.formatted_address).to be_nil
        expect(subject.complement).to be_nil
      end
    end

    context 'with options' do
      let(:pos) { '{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }' }
      let(:address_data) do
        '{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consola\\u00e7\\u00e3o", "short_name": "Consola\\u00e7\\u00e3o", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "S\\u00e3o Paulo", "short_name": "S\\u00e3o Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "S\\u00e3o Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil", "types": ["street_address"]}'
      end

      let(:options) do
        {
          pos: pos,
          address_st: 'Rua Augusta',
          address_data: address_data,
          lat: -23.5516433,
          lng: -46.6516703,
          formatted_address: 'R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil',
          complement: '8o andar'
        }
      end

      it 'should full all fields' do
        expect(subject.pos).to eq(JSON.parse(pos).deep_symbolize_keys)
        expect(subject.address_st).to eq('Rua Augusta')
        expect(subject.address_data).to eq(JSON.parse(address_data).deep_symbolize_keys)
        expect(subject.lat).to eq(-23.5516433)
        expect(subject.lng).to eq(-46.6516703)
        expect(subject.formatted_address).to eq('R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil')
        expect(subject.complement).to eq('8o andar')
      end
    end
  end
end
