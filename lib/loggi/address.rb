# frozen_string_literal: true

module Loggi
  class Address
    attr_accessor :pos, :address_st, :address_data, :lat, :lng, :formatted_address

    def initialize(options)
      @pos = JSON.parse(options[:pos]).deep_symbolize_keys if options[:pos]
      @address_st = options[:address_st] || options[:addressSt]
      build_address_data(options)
      build_coordinates(options)
      build_formated_address(options)
    end

    private

    def build_address_data(options)
      return unless options[:address_data] || options[:addressData]

      @address_data = JSON.parse(options[:address_data] || options[:addressData]).deep_symbolize_keys
    end

    def build_coordinates(options)
      @lat = options[:lat] || @addressData&.dig(:geometry, :location, :lat)
      @lng = options[:lng] || @addressData&.dig(:geometry, :location, :lng)
    end

    def build_formated_address(options)
      @formatted_address = options[:formatted_address] || @addressData&.dig(:formatted_address)
    end
  end
end
