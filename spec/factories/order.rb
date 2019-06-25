# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: Loggi::Order do
    initialize_with { new({}) }

    pk { 10 }
    packages { build_list(:package, 1) }
    status { 'allocating' }
    status_display { 'Em alocação' }
    original_eta { 2033 }
    total_time { nil }
    pricing { build :order_pricing }
    current_driver_position { build :driver_position }
  end
end
