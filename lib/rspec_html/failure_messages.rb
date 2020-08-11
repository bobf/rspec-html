# frozen_string_literal: true

module RSpecHTML
  # Provides failure messages for matchers.
  # rubocop:disable Layout/LineLength
  module FailureMessages
    def contain_text(actual, expected)
      return "Expected <#{actual.name}> to contain '#{expected}' but the element did not exist." if actual.element.nil?

      "Expected text in <#{actual.name}> #{(actual.text&.strip || '').inspect} to contain #{expected.inspect} but it did not."
    end
  end
  # rubocop:enable Layout/LineLength
end
