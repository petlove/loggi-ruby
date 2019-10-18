# frozen_string_literal: true

module Loggi
  module Services
    class OrderCreator < Base
      class OrderCreatorError < ::Loggi::Exceptions::ServiceException; end

      attr_accessor :shop, :pickups, :packages

      def initialize(options)
        super()
        @shop = build_nested(options, %i[shop], Shop)
        @pickups = build_nested_array(options, %i[pickups], Pickup)
        @packages = build_nested_array(options, %i[packages], Package)
      end

      def create!
        response = request!
        orders = response.dig(:createOrder, :orders)
        details = { request: query, response: response }

        raise OrderCreatorError, response.dig(:createOrder, :errors).to_json, details.to_json unless orders&.any?

        orders.each do |order|
          order.tap { |o| o[:packages].each(&method(:tracking_url!)) }
        end

        { data: orders.map { |order| Loggi::Order.new(order) } }.merge(details)
      end

      def login_required?
        true
      end

      def query
        <<-QUERY
          mutation {
            createOrder(input: {
              shopId: #{@shop.pk}
              pickups: #{pickups_query}
              packages: #{packages_query}
            }) {
              success
              shop {
                pk
                name
              }
              orders {
                pk
                pricing {
                  totalCm
                }
                packages {
                  pk
                  status
                  shareds {
                    edges {
                      node {
                        trackingUrl
                      }
                    }
                  }
                  pickupWaypoint {
                    instructions
                    index
                    indexDisplay
                    eta
                    legDistance
                  }
                  waypoint {
                    instructions
                    index
                    indexDisplay
                    eta
                    legDistance
                    addressSt
                    addressNumber
                    addressComplement
                  }
                }
              }
              errors {
                field
                message
              }
            }
          }
        QUERY
      end

      private

      def packages_query
        <<-QUERY
          [
            #{@packages.map { |package| package_query(package) }.join(',')}
          ]
        QUERY
      end

      def pickups_query
        <<-QUERY
          [
            #{@pickups.map { |pickup| pickup_query(pickup) }.join(',')}
          ]
        QUERY
      end

      def pickup_query(pickup)
        <<-QUERY
          {
            address: #{address_query(pickup.address)}
            instructions: "#{pickup.instructions}"
          }
        QUERY
      end

      def address_query(address)
        <<-QUERY
          {
            #{"lat: #{address.lat}" if address.lat}
            #{"lng: #{address.lng}" if address.lng}
            address: "#{address.formatted_address}"
            complement: "#{address.complement}"
          }
        QUERY
      end

      def package_query(package)
        <<-QUERY
          {
            pickupIndex: #{package.pickup_index}
            recipient: #{recipient_query(package.recipient)}
            address: #{address_query(package.address)}
            charge: #{charge_query(package.charge)}
            dimensions: #{dimensions_query(package.dimensions)}
            instructions: "#{package.instructions}"
          }
        QUERY
      end

      def recipient_query(recipient)
        <<-QUERY
          {
            name: "#{recipient.name}"
            phone: "#{recipient.phone}"
          }
        QUERY
      end

      def charge_query(charge)
        <<-QUERY
          {
            value: "#{charge.value.to_f.round(2)}"
            method: #{charge.method}
            change: "#{charge.change.to_f.round(2)}"
          }
        QUERY
      end

      def dimensions_query(dimensions)
        <<-QUERY
          {
            width: #{dimensions.width}
            height: #{dimensions.height}
            length: #{dimensions.length}
          }
        QUERY
      end
    end
  end
end
