# frozen_string_literal: true

module Loggi
  class Package < Base
    attr_accessor :pickup_index, :recipient, :address, :charge, :dimensions

    def initialize(options)
      @pickup_index = options[:pickup_index] || options[:pickupIndex] || 0
      @recipient = build_nested(options, %i[recipient], Recipient)
      @address = build_nested(options, %i[address], Address)
      @charge = build_nested(options, %i[charge], Charge)
      @dimensions = build_nested(options, %i[dimensions], Dimensions)
    end
  end
end
