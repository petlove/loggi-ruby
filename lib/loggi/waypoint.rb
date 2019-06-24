# frozen_string_literal: true

module Loggi
  class Waypoint
    attr_accessor :instructions, :index, :index_display, :eta, :leg_distance

    def initialize(options)
      @instructions = options[:instructions]
      @index = options[:index]
      @index_display = options[:index_display] || options[:indexDisplay]
      @eta = options[:eta]
      @leg_distance = options[:leg_distance] || options[:legDistance]
    end
  end
end
