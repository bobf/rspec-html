# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches text or regex within a given DOM element (strips HTML tags and compares text content only).
    class MatchText
      include Base

      diffable

      def match(actual)
        @rspec_actual = actual&.text
        return (actual&.text || '').include?(@expected.to_s) unless @expected.is_a?(Regexp)

        @expected.match(actual&.text || '')
      end
    end
  end
end
