# frozen_string_literal: true

module Loggi
  module Services
    class Base < Loggi::Base
      class WithoutCredentialHeadersError < StandardError; end

      attr_accessor :credential

      def initialize(credential = Loggi::Configuration.credential)
        @credential = credential || Loggi::Configuration.credential
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

      def tracking_url!(package)
        package[:tracking_urls] = package.dig(:shareds, :edges).map { |edge| edge.dig(:node, :trackingUrl) }
      end

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
        raise WithoutCredentialHeadersError unless @credential&.api_key || @credential&.email

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
