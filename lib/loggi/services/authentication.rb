# frozen_string_literal: true

module Loggi
  module Services
    class Authentication < Base
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
