# frozen_string_literal: true

RSpec.describe Loggi::Order, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.shop).to be_nil
        expect(subject.pickups).to be_nil
        expect(subject.packages).to be_nil
      end
    end

    context 'with options' do
      context 'with nested models' do
        let(:shop) { build :shop }
        let(:pickups) { build_list :pickup, 1 }
        let(:packages) { build_list :package, 1 }
        let(:options) { { shop: shop, pickups: pickups, packages: packages } }

        it 'should full all fields' do
          expect(subject.shop).to eq(shop)
          expect(subject.pickups).to eq(pickups)
          expect(subject.packages).to eq(packages)
        end
      end

      context 'with hash' do
        let(:options) do
          {
            shop: {
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
            },
            pickups: [
              {
                address: {
                  pos: '{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }',
                  addressSt: 'Rua Augusta',
                  addressData: '{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consolação", "short_name": "Consolação", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "São Paulo", "short_name": "São Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "São Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consolação, São Paulo - SP, Brazil", "types": ["street_address"]}',
                  lat: -23.5516433,
                  lng: -46.6516703,
                  formatted_address: 'R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil',
                  complement: '8o andar'
                }
              }
            ],
            packages: [
              {
                pickup_index: 0,
                recipient: {
                  name: 'Client XYZ',
                  phone: '1199678890'
                },
                address: {
                  pos: '{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }',
                  addressSt: 'Rua Augusta',
                  addressData: '{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consolação", "short_name": "Consolação", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "São Paulo", "short_name": "São Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "São Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consolação, São Paulo - SP, Brazil", "types": ["street_address"]}',
                  lat: -23.5516433,
                  lng: -46.6516703,
                  formatted_address: 'R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil',
                  complement: '8o andar'
                },
                charge: {
                  value: 10,
                  method: 2,
                  change: 5
                },
                dimensions: {
                  width: 10,
                  height: 11,
                  length: 12
                }
              }
            ]
          }
        end

        it 'should full all fields' do
          expect(subject.shop).to be_a(Loggi::Shop)
          expect(subject.pickups.all? { |pickup| pickup.is_a?(Loggi::Pickup) }).to be_truthy
          expect(subject.packages.all? { |package| package.is_a?(Loggi::Package) }).to be_truthy
        end
      end
    end
  end
end
