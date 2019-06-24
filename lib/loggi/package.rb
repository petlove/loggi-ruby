# frozen_string_literal: true

module Loggi
  class Package < Base
    attr_accessor :pickup_index, :recipient, :address, :charge, :dimensions, :instructions, :pk, :status,
                  :pickup_waypoint, :waypoint

    def initialize(options)
      @pk = options[:pk]
      @status = options[:status]
      @instructions = options[:instructions]
      @pickup_index = options[:pickup_index] || options[:pickupIndex] || 0
      @pickup_waypoint = build_nested(options, %i[pickup_waypoint pickupWaypoint], Waypoint)
      @waypoint = build_nested(options, %i[waypoint], Waypoint)
      @recipient = build_nested(options, %i[recipient], Recipient)
      @address = build_nested(options, %i[address], Address)
      @charge = build_nested(options, %i[charge], Charge)
      @dimensions = build_nested(options, %i[dimensions], Dimensions)
    end
  end
end
