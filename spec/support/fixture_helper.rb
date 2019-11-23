# frozen_string_literal: true

module FixtureHelper
  def fixture(type, name)
    RSpecHTML.root.join('spec', 'fixtures', type.to_s, "#{name}.#{type}")
  end
end
