# frozen_string_literal: true

module Loggi
  class Waypoint
    attr_accessor :instructions, :index, :index_display, :eta, :leg_distance, :address_st, :address_number,
                  :address_complement, :address_data

    def initialize(options)
      @instructions = options[:instructions]
      @index = options[:index]
      @index_display = options[:index_display] || options[:indexDisplay]
      @eta = options[:eta]
      @leg_distance = options[:leg_distance] || options[:legDistance]
      @address_st = options[:addressSt] || options[:address_st]
      @address_number = options[:addressNumber] || options[:address_number]
      @address_complement = options[:addressComplement] || options[:address_complement]
      build_address_data(options)
    end

    private

    def build_address_data(options)
      return unless options[:address_data] || options[:addressData]

      @address_data = JSON.parse(options[:address_data] || options[:addressData]).deep_symbolize_keys
    end
  end
end
