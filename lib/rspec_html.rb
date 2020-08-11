# frozen_string_literal: true

require 'nokogiri'
require 'pathname'

require 'rspec_html/searchable'
require 'rspec_html/element'
require 'rspec_html/tags'
require 'rspec_html/matchers'

# Support module for rspec/html
module RSpecHTML
  class Error < StandardError; end
  class NoResponseError < Error; end
  def self.root
    Pathname.new(__dir__).parent
  end
end

RSpec.configure { |config| config.include RSpecHTML::Matchers }
