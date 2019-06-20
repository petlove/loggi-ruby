# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: Loggi::Order do
    initialize_with { new({}) }

    shop { build :shop }
    pickups { build_list :pickup, 1 }
    packages { build_list :package, 1 }
  end
end
