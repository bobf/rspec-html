# frozen_string_literal: true

require 'rspec_html/matchers/base'
require 'rspec_html/matchers/contain_text'
require 'rspec_html/matchers/contain_tag'

module RSpecHTML
  # Provides matchers for identifying elements and text within a DOM element.
  module Matchers
    extend RSpec::Matchers::DSL
    extend RSpec::Matchers::DSL::Macros

    def self.define_matcher(name, class_)
      matcher name do |expected, options|
        rspec_html_matcher = class_.new(expected, options)
        match do |actual|
          @actual = rspec_html_matcher.actual
          rspec_html_matcher.match(actual)
        end
        description { rspec_html_matcher.description }
        failure_message { |actual| rspec_html_matcher.failure_message(actual) }
        diffable if class_.diffable?
      end
    end

    define_matcher(:contain_text, ContainText)
    define_matcher(:contain_tag, ContainTag)
  end
end
