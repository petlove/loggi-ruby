# frozen_string_literal: true

FactoryBot.define do
  factory :charge, class: Loggi::Charge do
    initialize_with { new(method: 2) }

    value { 10 }
    change { 5 }
  end
end
