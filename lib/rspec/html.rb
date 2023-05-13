# frozen_string_literal: true

require 'rspec'
require 'rspec_html'

require 'rspec/html/version'

module RSpec
  # Module extension for RSpec::SharedContext
  module HTML
    def document
      RSpecHTML::Element.new(Nokogiri::HTML.parse(response.body), :document)
    rescue NameError
      raise RSpecHTML::NoResponseError, 'No `response` object found. Make a request first.'
    end

    def parse_html(content)
      RSpecHTML::Element.new(Nokogiri::HTML.parse(content), :document)
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::HTML
  config.backtrace_exclusion_patterns << %r{/lib/rspec/html}
end
