# frozen_string_literal: true

require 'rspec_html/matchers/base'
require 'rspec_html/matchers/contain_text'
require 'rspec_html/matchers/contain_tag'
require 'rspec_html/matchers/match_text'

module RSpecHTML
  # Provides matchers for identifying elements and text within a DOM element.
  module Matchers
    extend RSpec::Matchers::DSL
    extend RSpec::Matchers::DSL::Macros

    # rubocop:disable Metrics/MethodLength
    def self.define_matcher(name, class_)
      matcher name do |expected, options|
        rspec_html_matcher = class_.new(expected, options || {})
        match do |actual|
          rspec_html_matcher
            .save_actual(actual)
            .match(actual)
            .tap { @actual = rspec_html_matcher.rspec_actual }
        end
        description { rspec_html_matcher.description }
        failure_message { rspec_html_matcher.failure_message }
        diffable if class_.diffable?
      end
    end
    # rubocop:enable Metrics/MethodLength

    define_matcher(:contain_text, ContainText)
    define_matcher(:contain_tag, ContainTag)
    define_matcher(:match_text, MatchText)
  end
end
