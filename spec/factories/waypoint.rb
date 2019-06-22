# frozen_string_literal: true

FactoryBot.define do
  factory :waypoint, class: Loggi::Waypoint do
    initialize_with { new({}) }

    instructions { 'Entregar pedido de Client Xyz, cobrar R$ 10.00 com cartão de débito. (Deixar pedido na escada)' }
    index { 1 }
    index_display { 'B' }
    eta { 1_561_234_918 }
    leg_distance { 2225 }
  end
end
