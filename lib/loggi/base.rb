# frozen_string_literal: true

module Loggi
  class Base
    private

    def build_nested(options, nested_key, nested_class)
      return unless options[nested_key]

      options[nested_key].is_a?(nested_class) ? options[nested_key] : nested_class.new(options[nested_key])
    end
  end
end
