# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches text or regex within a given DOM element (strips HTML tags and compares text content only).
    class MatchText
      include Base
      include Countable

      diffable

      def match(actual, expected_count:, expected_count_type:)
        raise_argument_error unless actual.is_a?(RSpecHTML::Element)
        @expected_count = expected_count
        @expected_count_type = expected_count_type
        @rspec_actual = actual&.text
        return regexp_match?(actual) || regexp_siblings_match?(actual) if @expected.is_a?(Regexp)

        string_match?(actual) || string_siblings_match?(actual)
      end

      private

      def regexp_match?(actual)
        return @expected.match(actual&.text || '') if @expected_count.nil?

        @actual_count = actual&.text&.scan(@expected)&.size
        count_match?
      end

      def regexp_siblings_match?(actual)
        actual.siblings.any? { |sibling| @expected.match(sibling&.text || '') }
      end

      def string_match?(actual)
        return (actual&.text || '').include?(@expected.to_s) if @expected_count.nil?

        @actual_count = actual&.text&.scan(@expected)&.size
        count_match?
      end

      def string_siblings_match?(actual)
        actual.siblings.any? { |sibling| (sibling&.text || '').include?(@expected.to_s) }
      end

      def raise_argument_error
        raise ArgumentError, 'Expected RSpecHTML::Element with `match_text` matcher.'
      end
    end
  end
end
