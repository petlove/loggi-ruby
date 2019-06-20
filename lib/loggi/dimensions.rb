# frozen_string_literal: true

module Loggi
  class Dimensions
    attr_accessor :width, :height, :length

    def initialize(options)
      @width = options[:width]
      @height = options[:height]
      @length = options[:length]
    end
  end
end
