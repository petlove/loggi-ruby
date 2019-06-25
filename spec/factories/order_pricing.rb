# frozen_string_literal: true

FactoryBot.define do
  factory :order_pricing, class: Loggi::OrderPricing do
    initialize_with { new({}) }

    total_cm { '23.50' }
  end
end
