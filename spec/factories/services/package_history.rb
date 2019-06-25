# frozen_string_literal: true

FactoryBot.define do
  factory :services_package_history, class: Loggi::Services::PackageHistory do
    initialize_with { new({}) }

    pk { 231_814 }
  end
end
