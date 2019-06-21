# frozen_string_literal: true

module Loggi
  class Credential
    attr_accessor :email, :password, :api_key

    def initialize(options)
      @email = options[:email]
      @password = options[:password]
      @api_key = options[:api_key]
    end

    def authenticate!
      Services::Authentication.authenticate!(self)
    end
  end
end
