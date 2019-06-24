# frozen_string_literal: true

module Loggi
  class Charge
    attr_accessor :value, :method, :change

    def initialize(options)
      @value = options[:value]
      @method = options[:method]
      @change = options[:change]
    end

    def description
      @description ||= ChargeOption.by_method(@method)
    end
  end
end
