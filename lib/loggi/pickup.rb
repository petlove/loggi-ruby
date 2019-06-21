# frozen_string_literal: true

module Loggi
  class Pickup
    attr_accessor :address

    def initialize(options)
      @address = options[:address]
    end
  end
end
