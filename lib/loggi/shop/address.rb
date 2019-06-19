# frozen_string_literal: true

module Loggi
  class Shop
    class Address
      attr_accessor :value, :percentage

      def initialize(options)
        @pos = JSON.parse(options[:pos]) if options[:pos]
        @address_st = options[:addressST]
        @address_data = JSON.parse(options[:addressData]) if options[:addressData]
      end
    end
  end
end
