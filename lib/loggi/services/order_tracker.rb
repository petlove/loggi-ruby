# frozen_string_literal: true

module Loggi
  module Services
    class OrderTracker < Base
      class OrderTrackerError < StandardError; end

      attr_accessor :pk

      def initialize(options)
        super()
        @pk = options[:pk]
      end

      def track!
        response = request!
        order = response[:retrieveOrderWithPk]
        raise OrderTrackerError unless order

        order.tap { |o| o[:packages].each(&method(:tracking_url!)) }
      end

      def login_required?
        true
      end

      def query
        <<-QUERY
          query {
            retrieveOrderWithPk(orderPk: #{@pk}) {
              status
              statusDisplay
              originalEta
              totalTime
              pricing {
                totalCm
              }
              packages {
                waypoint {
                  addressComplement
                  addressSt
                  addressNumber
                  addressData
                }
                pickupWaypoint {
                  instructions
                  index
                  indexDisplay
                  eta
                  legDistance
                  addressData
                }
                pk
                status
                statusCode
                statusCodeDisplay
                shareds {
                  edges {
                    node {
                      trackingUrl
                    }
                  }
                }
              }
              currentDriverPosition {
                lat
                lng
                currentWaypointIndex
                currentWaypointIndexDisplay
              }
            }
          }
        QUERY
      end

      private

      def tracking_url!(package)
        package[:tracking_urls] = package.dig(:shareds, :edges).map { |edge| edge.dig(:node, :trackingUrl) }
      end
    end
  end
end
