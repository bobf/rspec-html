# frozen_string_literal: true

module RSpecHTML
  module Matchers
    # Mix-in class to provide a uniform interface and message templating for all matchers.
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

      attr_reader :rspec_actual

      def initialize(expected, options)
        @expected = expected
        @options = options
      end

      def description
        template(:description, @options, @expected)
      end

      def failure_message
        template(:failure, @options, @expected, @actual)
      end

      def save_actual(actual)
        @actual = actual
        self
      end

      def reconstituted(element, options)
        RSpecHTML::Element.reconstituted(element, options)
      end

      private

      def template(type, options, expected, actual = nil)
        ERB.new(template_path(type).read).result(binding)
      end

      def template_path(type)
        RSpecHTML.root.join('templates', type.to_s, "#{filename}.erb")
      end

      def filename
        _, _, name = self.class.name.rpartition('::')
        (name[0] + name[1..-1].gsub(/(.)([A-Z])/, '\1_\2')).downcase
      end
    end
  end
end
