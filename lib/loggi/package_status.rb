# frozen_string_literal: true

module Loggi
  class PackageStatus
    attr_accessor :status, :status_display, :detailed_status_display, :status_code, :updated

    def initialize(options)
      @status = options[:status]
      @status_display = options[:statusDisplay] || options[:status_display]
      @detailed_status_display = options[:detailedStatusDisplay] || options[:detailed_status_display]
      @status_code = options[:statusCode] || options[:status_code]
      @updated = ActiveSupport::TimeZone['America/Sao_Paulo'].parse(options[:updated]) if options[:updated]
    end
  end
end
