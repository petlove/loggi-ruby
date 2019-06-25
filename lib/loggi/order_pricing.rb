# frozen_string_literal: true

module Loggi
  class OrderPricing
    attr_accessor :total_cm

    def initialize(options)
      @total_cm = options[:total_cm] || options[:totalCm]
    end
  end
end
