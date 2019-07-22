# frozen_string_literal: true

module Loggi
  class Order < Base
    attr_accessor :pk, :packages, :status, :status_display, :original_eta, :total_time, :pricing,
                  :current_driver_position

    def initialize(options)
      update_fields(options)
    end

    def track!
      tap { update_fields(Services::OrderTracker.new(pk: @pk).track!) }
    end

    class << self
      def create!(options)
        Services::OrderCreator.new(options).create!
      end
    end

    private

    def update_fields(options)
      @pk = options[:pk]
      @status = options[:status]
      @status_display = options[:status_display] || options[:statusDisplay]
      @original_eta = options[:original_eta] || options[:originalETA]
      @total_time = options[:total_time] || options[:totalTime]
      @pricing = build_nested(options, %i[pricing], OrderPricing)
      @current_driver_position = build_nested(options, %i[current_driver_position], DriverPosition)
      @packages = build_nested_array(options, %i[packages], Package)
    end
  end
end
