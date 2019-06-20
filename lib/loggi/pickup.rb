# frozen_string_literal: true

module Loggi
  class Pickup < Base
    attr_accessor :address

    def initialize(options)
      @address = build_nested(options, :address, Address)
    end
  end
end
