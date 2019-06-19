# frozen_string_literal: true

module Loggi
  class Shop
    class ChargeOption
      attr_accessor :label

      def initialize(options)
        @label = options[:label]
      end
    end
  end
end
