# frozen_string_literal: true

module Loggi
  module Services
    class Base
      class UnlessCredentialHeaders < StandardError; end

      attr_accessor :credential

      def initialize(credential = Loggi::Configuration.credential)
        @credential = credential
      end

      def query
        raise NotImplementedError
      end

      def login_required?; end

      def request!
        handle_response(::HTTP.headers(headers).post(api_url, json: payload))
      end

      def handle_response(response)
        JSON.parse(response).deep_symbolize_keys[:data]
      end

      private

      def payload
        { query: query.squish }
      end

      def api_url
        ENV['LOGGI_API_URL'].to_s.freeze
      end

      def headers
        login_required? ? authenticated_header : default_header
      end

      def authorization_key
        raise UnlessCredentialHeaders unless @credential.api_key || @credential.email

        "ApiKey #{@credential.email}:#{@credential.api_key}"
      end

      def authenticated_header
        { 'Content-Type' => 'application/json', 'authorization' => authorization_key }
      end

      def default_header
        { 'Content-Type' => 'application/json' }
      end
    end
  end
end
