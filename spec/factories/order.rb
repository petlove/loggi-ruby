# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: Loggi::Order do
    initialize_with { new({}) }

    pk { 10 }
    packages { build_list(:package, 1) }
  end
end
