# frozen_string_literal: true

module Loggi
  class Recipient
    attr_accessor :name, :phone

    def initialize(options)
      @name = options[:name]
      @phone = options[:phone]
    end
  end
end
