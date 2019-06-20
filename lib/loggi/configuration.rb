# frozen_string_literal: true

require 'singleton'

module Loggi
  class Configuration
    include Singleton

    attr_accessor :credential

    class << self
      def configure!(credential)
        instance.credential = credential
        authenticate!
      end

      def credential
        instance.credential
      end
    end

    private

    def authenticate!
      return unless @credential&.is_a?(Loggi::Credential) && @credential&.api_key && @credential&.email

      @credential.authenticate!
    end
  end
end
