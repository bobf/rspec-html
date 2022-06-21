# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches text or regex within a given DOM element (strips HTML tags and compares text content only).
    class MatchText
      include Base

      diffable

      def match(actual)
        raise_argument_error unless actual.is_a?(RSpecHTML::Element)
        @rspec_actual = actual&.text
        return regexp_match?(actual) || regexp_siblings_match?(actual) if @expected.is_a?(Regexp)

        string_match?(actual) || string_siblings_match?(actual)
      end

      private

      def regexp_match?(actual)
        @expected.match(actual&.text || '')
      end

      def regexp_siblings_match?(actual)
        actual.siblings.any? { |sibling| @expected.match(sibling&.text || '') }
      end

      def string_match?(actual)
        (actual&.text || '').include?(@expected.to_s)
      end

      def string_siblings_match?(actual)
        actual.siblings.any? { |sibling| (sibling&.text || '').include?(@expected.to_s) }
      end

      def raise_argument_error
        raise ArumentError, 'Expected RSpecHTML::Element with `match_text` matcher.'
      end
    end
  end
end
