# frozen_string_literal: true

module Loggi
  class Pickup < Base
    attr_accessor :address, :instructions

    def initialize(options)
      @instructions = options[:instructions]
    end
  end
end
