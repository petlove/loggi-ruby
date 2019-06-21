# frozen_string_literal: true

FactoryBot.define do
  factory :pickup, class: Loggi::Pickup do
    initialize_with { new({}) }

    address { build :address }
  end
end
