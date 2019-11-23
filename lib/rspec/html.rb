# frozen_string_literal: true

require 'rspec'
require 'rspec_html'

require 'rspec/html/version'

module RSpec
  # Module extension for RSpec::SharedContext
  module HTML
    def document
      RSpecHTML::Document.new(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::HTML
  config.backtrace_exclusion_patterns << %r{/lib/rspec/html}
end
