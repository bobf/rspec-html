# frozen_string_literal: true

require 'bundler/setup'
require 'rspec/its'
require 'i18n'
require 'devpack'
require 'active_support/core_ext/array/access' # Provides #second, #third, #fourth etc.

require 'rspec/html'
require 'rspec_html'

I18n.load_path << RSpecHTML.root.join('spec', 'fixtures', 'locale.yml')
I18n.default_locale = :spec

Dir[RSpecHTML.root.join('spec/support/**/*.rb')].sort.each { |path| require path }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.include FixtureHelper

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
