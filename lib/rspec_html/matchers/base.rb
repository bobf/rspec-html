module RSpecHTML
  module Matchers
    module Base
      def self.included(base)
        base.class_eval do
          class << self
            def diffable
              @diffable = true
            end

            def diffable?
              @diffable
            end
          end
        end
      end

      def initialize(expected, options = {})
        @expected = expected
        @options = options
      end

      def description
        template(:description, @expected)
      end

      def failure_message(actual)
        template(:failure, @expected, actual)
      end

      private

      def template(type, expected, actual = nil)
        ERB.new(template_path(type).read).result(binding)
      end

      def template_path(type)
        RSpecHTML.root.join('templates', type.to_s, "#{filename}.erb")
      end

      def filename
        _, _, name = self.class.name.rpartition('::')
        (name[0] + name[1..].gsub(/(.)([A-Z])/, '\1_\2')).downcase
      end
    end
  end
end
