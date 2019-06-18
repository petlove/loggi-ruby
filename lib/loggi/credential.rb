# frozen_string_literal: true

module Loggi
  class Credential
    attr_accessor :email, :password, :api_key
    class UserNotFoundError < StandardError; end

    def initialize(options)
      @email = options[:email]
      @password = options[:password]
      @api_key = options[:api_key]
    end

    def authenticate!
      Services::Authentication.new(self).request!.tap do |response|
        user = response[:login][:user]
        raise UserNotFoundError unless user

        @api_key = user[:apiKey]
      end
    end
  end
end
