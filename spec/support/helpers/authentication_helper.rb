# frozen_string_literal: true

module Helpers
  module AuthenticationHelper
    def authenticate!
      Loggi::Configuration.configure!(Loggi::Credential.new(
                                        email: ENV['LOGGI_API_EMAIL'],
                                        password: ENV['LOGGI_API_PASSWORD'],
                                        api_key: ENV['LOGGI_API_KEY']
                                      ))
    end
  end
end
