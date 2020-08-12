# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches text within a given DOM element.
    class ContainText
      include Base

      diffable

      def match(actual)
        @actual = actual&.text&.strip
        (actual&.text || '').include?(@expected.to_s)
      end
    end
  end
end
