# frozen_string_literal: true

FactoryBot.define do
  factory :address, class: Loggi::Address do
    initialize_with { new({}) }

    pos { JSON.parse('{ "type": "Point", "coordinates": [ -46.6516703, -23.5516433 ] }') }
    address_st { 'Rua Augusta' }
    # rubocop:disable Metrics/LineLength
    address_data do
      JSON.parse('{"geometry": {"location": {"lat": -23.5516433, "lng": -46.6516703}}, "address_components": [{"long_name": "588", "short_name": "588", "types": ["street_number"]}, {"long_name": "Rua Augusta", "short_name": "R. Augusta", "types": ["route"]}, {"long_name": "Consolação", "short_name": "Consolação", "types": ["political", "sublocality", "sublocality_level_1"]}, {"long_name": "São Paulo", "short_name": "São Paulo", "types": ["administrative_area_level_2", "political"]}, {"long_name": "São Paulo", "short_name": "SP", "types": ["administrative_area_level_1", "political"]}, {"long_name": "Brazil", "short_name": "BR", "types": ["country", "political"]}, {"long_name": "01304", "short_name": "01304", "types": ["postal_code", "postal_code_prefix"]}], "partial_match": true, "formatted_address": "R. Augusta, 588 - Consolação, São Paulo - SP, Brazil", "types": ["street_address"]}')
    end
    # rubocop:enable Metrics/LineLength
    lat { -23.5516433 }
    lng { -46.6516703 }
    formatted_address { 'R. Augusta, 588 - Consola\\u00e7\\u00e3o, S\\u00e3o Paulo - SP, Brazil' }
    complement { '8o andar' }
  end
end
