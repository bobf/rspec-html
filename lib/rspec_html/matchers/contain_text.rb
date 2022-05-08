# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Matches text within a given DOM element (strips HTML tags and compares text content only).
    # (Deprecated in favour of `#match_text`.
    class ContainText
      include Base

      diffable

      def match(actual)
        warn('[rspec-html] The `contain_text` matcher is deprecated. Use `match_text` instead.')
        @rspec_actual = actual&.text
        (actual&.text || '').include?(@expected.to_s)
      end
    end
  end
end
