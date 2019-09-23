# frozen_string_literal: true

module Loggi
  module Exceptions
    class ServiceException < StandardError
      attr_reader :details

      def initialize(message, details = nil)
        super(message)
        @details = details
      end
    end
  end
end
