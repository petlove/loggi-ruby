# frozen_string_literal: true

module Loggi
  class Base
    private

    def build_nested(options, nested_keys, nested_class)
      nested_keys.map { |nested_key| build_nested_for_one_key(options, nested_key, nested_class) }
                 .compact.first
    end

    def build_nested_array(options, nested_keys, nested_class)
      nested_keys.map { |nested_key| build_nested_array_for_one_key(options, nested_key, nested_class) }
                 .compact.first
    end

    def build_nested_for_one_key(options, nested_key, nested_class)
      return unless options[nested_key]

      options[nested_key].is_a?(nested_class) ? options[nested_key] : nested_class.new(options[nested_key])
    end

    def build_nested_array_for_one_key(options, nested_key, nested_class)
      return unless options[nested_key]&.is_a?(Array)

      options[nested_key].map { |nested| nested.is_a?(nested_class) ? nested : nested_class.new(nested) }
    end
  end
end
