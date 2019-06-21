# frozen_string_literal: true

require 'singleton'

module Loggi
  class Configuration
    include Singleton

    attr_accessor :credential

    class << self
      def configure!(credential)
        instance.tap { |i| i.credential = credential }.authenticate!
      end

      def credential
        instance.credential
      end
    end

    def authenticate!
      return unless @credential.is_a?(Loggi::Credential) || @credential.email
      return if @credential.api_key
      return unless @credential.password

      @credential.authenticate!
    end
  end
end
