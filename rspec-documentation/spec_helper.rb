# frozen_string_literal: true

require 'rspec/html'
require 'rspec/file_fixtures'

require 'mail'

module ActionMailer
  # Stub for ActionMailer::Base to return an example delivered email.
  class Base
    def self.deliveries
      [Mail.new { body '<div class="welcome-message">Welcome to our website!</div>' }]
    end
  end
end

RSpec::Documentation.configure do |config|
  config.context do
    def get(path)
      @response_body = fixture("html#{path}.html").read
    end

    def post(path, params:) # rubocop:disable Lint/UnusedMethodArgument
      @response_body = fixture("html#{path}/create.html").read
    end

    def response
      double(body: @response_body)
    end

    subject { @response_body }
  end
end
