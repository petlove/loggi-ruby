# frozen_string_literal: true

module Loggi
  class Order < Base
    attr_accessor :shop, :pickups, :packages

    def initialize(options)
      @shop = build_nested(options, :shop, Shop)
      @pickups = build_nested_array(options, :pickups, Pickup)
      @packages = build_nested_array(options, :packages, Package)
    end
  end
end
