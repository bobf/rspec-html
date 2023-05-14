# frozen_string_literal: true

require 'nokogiri'

require 'pathname'
require 'forwardable'
require 'tempfile'

require 'rspec_html/tags'
require 'rspec_html/element'
require 'rspec_html/search'
require 'rspec_html/reconstituted_element'
require 'rspec_html/countable'
require 'rspec_html/matchers'
require 'rspec_html/browser'

# Support module for rspec/html
module RSpecHTML
  class Error < StandardError; end
  class NoResponseError < Error; end
  class ElementNotFoundError < Error; end

  def self.root
    Pathname.new(__dir__).parent
  end
end

RSpec.configure { |config| config.include RSpecHTML::Matchers }
