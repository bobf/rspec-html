# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches elements within a given DOM element.
    class ContainTag
      include Base
      include Countable

      def match(actual, expected_count:, expected_count_type:)
        @actual = actual
        @expected_count = expected_count
        @expected_count_type = expected_count_type
        return actual.public_send(@expected, @options).present? if @expected_count.nil?

        @actual_count = actual.public_send(@expected, @options).size
        count_match?
      end
    end
  end
end
