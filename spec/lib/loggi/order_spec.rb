# frozen_string_literal: true

RSpec.describe Loggi::Order, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.pk).to be_nil
        expect(subject.packages).to be_nil
      end
    end

    context 'with options' do
      context 'with nested models' do
        let(:packages) { build_list :package, 1 }
        let(:options) { { pk: 10, packages: packages } }

        it 'should full all fields' do
          expect(subject.pk).to eq(10)
          expect(subject.packages.all? { |package| package.is_a?(Loggi::Package) }).to be_truthy
        end
      end

      context 'with hash' do
        let(:options) do
          {
            pk: 10,
            packages: [
              {
                pk: 231_777,
                status: 'allocating',
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
                },
                instructions: 'Deixar pedido na escada',
                waypoint: {
                  instructions: 'Entregar pedido de Client Xyz, cobrar R$ 10.00 com cartão de débito. (Deixar pedido na escada)',
                  index: 1,
                  index_display: 'B',
                  eta: 1_561_234_918,
                  legDistance: 2225
                },
                pickup_waypoint: {
                  instructions: 'Entregar pedido de Client Xyz, cobrar R$ 10.00 com cartão de débito. (Deixar pedido na escada)',
                  index: 1,
                  index_display: 'B',
                  eta: 1_561_234_918,
                  legDistance: 2225
                }
              }
            ]
          }
        end

        it 'should full all fields' do
          expect(subject.pk).to eq(10)
          expect(subject.packages.all? { |package| package.is_a?(Loggi::Package) }).to be_truthy
        end
      end
    end
  end

  describe '#create!' do
    subject { described_class.create!({}) }

    after { subject }

    it 'should call create order service' do
      expect_any_instance_of(Loggi::Services::OrderCreator).to receive(:create!).once
    end
  end
end
