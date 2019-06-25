# frozen_string_literal: true

FactoryBot.define do
  factory :package, class: Loggi::Package do
    initialize_with { new({}) }

    pickup_index { 0 }
    instructions { 'Deixar pedido na escada' }
    signed_by_name { 'Baruch Spinoza' }
    signature_url { 'https://staging.loggi.com/wp-103805-protocolo.png' }
    recipient { build :recipient }
    address { build :address, formatted_address: 'R. Sansão Alves dos Santos, 138, Cidade Monções São Paulo - SP Brasil' }
    charge { build :charge }
    dimensions { build :dimensions }
    pk { 231_777 }
    status { 'allocating' }
    pickup_waypoint { build :waypoint }
    waypoint { build :waypoint }
    statuses { build_list :package_status, 1 }
    status_code { 1 }
    status_code_display { 'Agendado' }
    tracking_urls { %w[loggi.com/c/D4qcua9r/ loggi.com/c/62xpHC25/] }
  end
end
