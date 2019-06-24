# frozen_string_literal: true

FactoryBot.define do
  factory :pickup, class: Loggi::Pickup do
    initialize_with { new({}) }

    instructions { 'Deixar pedido na escada' }
    address { build :address }
  end
end
