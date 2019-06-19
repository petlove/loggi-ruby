# frozen_string_literal: true

FactoryBot.define do
  factory :shop_charge_option, class: Loggi::Shop::ChargeOption do
    initialize_with { new({}) }

    label { 'Cartão de Crédito' }
  end
end
