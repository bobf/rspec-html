module RSpecHTML
  module Matchers
    class ContainTag
      include Base

      def match(actual)
        actual.public_send(@expected, @options).present?
      end
    end
  end
end
