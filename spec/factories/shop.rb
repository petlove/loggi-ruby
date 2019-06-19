# frozen_string_literal: true

FactoryBot.define do
  factory :shop, class: Loggi::Shop do
    initialize_with { new({}) }

    pk { 129 }
    name { 'Coelho Burguer' }
    pickup_instructions { 'Retirar pacotes no balcão' }
    address { build :shop_address }
    charge_options { build_list :shop_charge_option, 1 }
  end
end
