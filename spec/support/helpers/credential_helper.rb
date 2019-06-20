# frozen_string_literal: true

module Helpers
  module CredentialHelper
    def authorize!
      Loggi::Configuration.configure(Loggi::Credential.new(
                                       email: ENV['LOGGI_API_EMAIL'],
                                       api_key: ENV['LOGGI_API_KEY']
                                     ))
    end
  end
end
