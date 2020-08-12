# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches elements within a given DOM element.
    class ContainTag
      include Base

      def match(actual)
        @actual = actual.to_s
        actual.public_send(@expected, @options).present?
      end
    end
  end
end
