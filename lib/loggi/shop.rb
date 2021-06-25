# frozen_string_literal: true

module Loggi
  class Shop
    attr_accessor :name, :pickup_instructions, :address, :charge_options, :payment_method

    def initialize(options)
      @name = options[:name]
      @pickup_instructions = options[:pickupInstructions]
      @address = Address.new(options[:address]) if options[:address]
      @payment_method = options[:paymentMethod].to_i

      return unless options[:chargeOptions].is_a?(Array)

      @charge_options = options[:chargeOptions].map { |charge_option| ChargeOption.new(charge_option) }
    end

    class << self
      def list
        Services::Shops.list
      end
    end
  end
end
