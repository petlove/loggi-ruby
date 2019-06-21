# frozen_string_literal: true

module Loggi
  module Services
    class Authentication < Base
      class UserNotFoundError < StandardError; end

      class << self
        def authenticate!(credential)
          response = new(credential).request!
          user = response[:login][:user]
          raise UserNotFoundError unless user

          credential.api_key = user[:apiKey]
        end
      end

      def query
        <<-QUERY
          mutation {
            login(input: {
                  email: "#{@credential.email}",
                  password: "#{@credential.password}"
                  }) {
              user {
                apiKey
              }
            }
          }
        QUERY
      end
    end
  end
end
