# frozen_string_literal: true

module Loggi
  class DriverPosition
    attr_accessor :lat, :lng, :current_waypoint_index, :current_waypoint_index_display

    def initialize(options)
      @lat = options[:lat]
      @lng = options[:lng]
      @current_waypoint_index = options[:currentWaypointIndex] || options[:current_waypoint_index]
      @current_waypoint_index_display = options[:currentWaypointIndexDisplay] ||
                                        options[:current_waypoint_index_display]
    end
  end
end
