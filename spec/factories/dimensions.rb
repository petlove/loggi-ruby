# frozen_string_literal: true

FactoryBot.define do
  factory :dimensions, class: Loggi::Dimensions do
    initialize_with { new({}) }

    width { 10 }
    height { 10 }
    length { 5 }
  end
end
