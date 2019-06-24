# frozen_string_literal: true

module Loggi
  class Order < Base
    attr_accessor :pk, :packages

    def initialize(options)
      @pk = options[:pk]
      @packages = build_nested_array(options, %i[packages], Package)
    end

    class << self
      def create!(options)
        Services::OrderCreator.new(options).create!
      end
    end
  end
end
