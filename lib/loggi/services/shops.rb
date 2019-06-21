# frozen_string_literal: true

module Loggi
  module Services
    class Shops < Base
      class ShopsNotFoundError < StandardError; end
      class << self
        def list
          response = new.request!
          shops = response.dig(:allShops, :edges)
          raise ShopsNotFoundError unless shops

          shops.map { |shop| Loggi::Shop.new(shop[:node]) }
        end
      end

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
