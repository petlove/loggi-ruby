# frozen_string_literal: true

FactoryBot.define do
  factory :charge_option, class: Loggi::ChargeOption do
    initialize_with { new({}) }

    label { 'Cartão de Crédito' }
  end
end
