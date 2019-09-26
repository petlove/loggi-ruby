# frozen_string_literal: true

FactoryBot.define do
  factory :package_status, class: Loggi::PackageStatus do
    initialize_with { new({}) }

    status { 'ns' }
    status_display { 'Não iniciada' }
    detailed_status_display { 'Agendado' }
    status_code { 1 }
    updated { ActiveSupport::TimeZone['America/Sao_Paulo'].parse('2019-04-24 13:48:33.126401') }
  end
end
