module RSpecHTML
  module Matchers
    class ContainText
      include Base

      diffable

      def match(actual)
        text = actual&.text || ''
        text.include?(@expected.to_s)
      end
    end
  end
end
