# frozen_string_literal: true

FactoryBot.define do
  factory :services_order_tracker, class: Loggi::Services::OrderTracker do
    initialize_with { new({}) }

    pk { 97_269 }
  end
end
