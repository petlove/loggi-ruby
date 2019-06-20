# frozen_string_literal: true

FactoryBot.define do
  factory :recipient, class: Loggi::Recipient do
    initialize_with { new({}) }

    name { 'Client XYZ' }
    phone { '1199678890' }
  end
end
