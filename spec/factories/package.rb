# frozen_string_literal: true

FactoryBot.define do
  factory :package, class: Loggi::Package do
    initialize_with { new({}) }

    pickup_index { 0 }
    instructions { 'Deixar pedido na escada' }
    recipient { build :recipient }
    address { build :address, formatted_address: 'R. Sansão Alves dos Santos, 138, Cidade Monções São Paulo - SP Brasil' }
    charge { build :charge }
    dimensions { build :dimensions }
    pk { 231_777 }
    status { 'allocating' }
    pickup_waypoint { build :waypoint }
    waypoint { build :waypoint }
  end
end
