# frozen_string_literal: true

require 'nokogiri'
require 'pathname'

require 'rspec_html/nameable'
require 'rspec_html/searchable'
require 'rspec_html/element'
require 'rspec_html/tags'

# Support module for rspec/html
module RSpecHTML
  def self.root
    Pathname.new(__dir__).parent
  end
end
