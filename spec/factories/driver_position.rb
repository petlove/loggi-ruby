# frozen_string_literal: true

FactoryBot.define do
  factory :driver_position, class: Loggi::DriverPosition do
    initialize_with { new({}) }

    lat { -23.54532882509319 }
    lng { -46.59718813284402 }
    current_waypoint_index { 0 }
    current_waypoint_index_display { 'A' }
  end
end
