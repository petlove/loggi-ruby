# frozen_string_literal: true

module Loggi
  module Services
    class CreateOrder < Base
      def login_required?
        true
      end

      def initialize(order, crendetial)
        super(crendetial)
        @order = order
      end

      def query
        <<-QUERY
          mutation {
            createOrder(input: {
              shopId: #{@order.shop.pk}
              pickups: #{pickups_query(@order.pickups)}
              packages: #{packages_query(@order.packages)}
            }) {
              success
              shop {
                pk
                name
              }
              orders {
                pk
                packages {
                  pk
                  status
                  pickupWaypoint {
                    index
                    indexDisplay
                    eta
                    legDistance
                  }
                  waypoint {
                    index
                    indexDisplay
                    eta
                    legDistance
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

      def packages_query(packages)
        <<-QUERY
          [
            #{packages.map { |package| package_query(package) }.join(',')}
          ]
        QUERY
      end

      def pickups_query(pickups)
        <<-QUERY
          [
            #{pickups.map { |pickup| pickup_query(pickup) }.join(',')}
          ]
        QUERY
      end

      def pickup_query(pickup)
        <<-QUERY
          {
            address: #{address_query(pickup.address)}
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
