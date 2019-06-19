# frozen_string_literal: true

module Loggi
  module Services
    class Shops < Base
      def login_required?
        true
      end

      def query
        <<-QUERY
          query {
            allShops {
              edges {
                node {
                  name
                  pickupInstructions
                  pk
                  address {
                    pos
                    addressSt
                    addressData
                  }
                  chargeOptions {
                    label
                  }
                }
              }
            }
          }
        QUERY
      end
    end
  end
end
