# frozen_string_literal: true

FactoryBot.define do
  factory :services_order_creator, class: Loggi::Services::OrderCreator do
    initialize_with { new({}) }

    shop { build :shop }
    pickups { build_list :pickup, 1 }
    packages { build_list :package, 1 }
  end
end
