# frozen_string_literal: true

module Loggi
  class Shop
    class PricingAreaDiscount
      attr_accessor :value, :percentage

      def initialize(options)
        @value = options[:value]
        @percentage = options[:percentage]
      end
    end
  end
end
