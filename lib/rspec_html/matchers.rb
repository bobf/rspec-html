# frozen_string_literal: true

RSpec::Matchers.define :contain_text do |expected|
  match do |actual|
    text = actual&.text || ''
    text.include?(expected.to_s)
  end

  failure_message do |actual|
    RSpecHTML::FailureMessages.contain_text(actual, expected)
  end
end
