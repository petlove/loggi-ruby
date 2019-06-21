# frozen_string_literal: true

module Loggi
  class Package < Base
    attr_accessor :pickup_index, :recipient, :address, :charge, :dimensions

    def initialize(options)
      @pickup_index = options[:pickup_index] || options[:pickupIndex] || 0
      @recipient = build_nested(options, :recipient, Recipient)
      @address = build_nested(options, :address, Address)
      @charge = build_nested(options, :charge, Charge)
      @dimensions = build_nested(options, :dimensions, Dimensions)
    end
  end
end
