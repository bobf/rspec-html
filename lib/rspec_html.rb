# frozen_string_literal: true

require 'nokogiri'
require 'pathname'

require 'rspec_html/nameable'
require 'rspec_html/searchable'
require 'rspec_html/body'
require 'rspec_html/document'
require 'rspec_html/head'
require 'rspec_html/title'

# Support module for rspec/html
module RSpecHTML
  def self.root
    Pathname.new(__dir__).parent
  end
end
