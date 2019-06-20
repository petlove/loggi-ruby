# frozen_string_literal: true

FactoryBot.define do
  factory :package, class: Loggi::Package do
    initialize_with { new({}) }

    pickup_index { 0 }
    recipient { build :recipient }
    address { build :address }
    charge { build :charge }
    dimensions { build :dimensions }
  end
end
