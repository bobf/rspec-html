# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods allowing an entity to specify its name
  module Nameable
    attr_reader :name
  end
end
