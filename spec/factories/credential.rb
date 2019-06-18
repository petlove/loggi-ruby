# frozen_string_literal: true

FactoryBot.define do
  factory :credential, class: Loggi::Credential do
    initialize_with { new({}) }

    email { 'loggistaging@loggi.com' }
    password { '123456' }
  end
end
