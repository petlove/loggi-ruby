# frozen_string_literal: true

module Loggi
  class Package < Base
    attr_accessor :pickup_index, :recipient, :address, :charge, :dimensions, :instructions, :pk, :status,
                  :pickup_waypoint, :waypoint, :signed_by_name, :signature_url, :statuses, :status_code,
                  :status_code_display, :tracking_urls

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
      @status_code = options[:status_code] || options[:statusCode]
      @status_code_display = options[:status_code_display] || options[:statusCodeDisplay]
      @tracking_urls = options[:tracking_urls]
      build_history_fields(options)
    end

    def history!
      tap { build_history_fields(Services::PackageHistory.new(pk: @pk).get) }
    end

    private

    def build_history_fields(options)
      build_signed_by_name(options)
      build_signature_url(options)
      build_statuses(options)
    end

    def build_signed_by_name(options)
      @signed_by_name = options[:signedByName] || options[:signed_by_name]
    end

    def build_signature_url(options)
      @signature_url = options[:signatureUrl] || options[:signature_url]
    end

    def build_statuses(options)
      @statuses = build_nested_array(options, %i[statuses], PackageStatus)
    end
  end
end
