# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods for searching text content of HTML entities
  module Searchable
    def include?(val)
      @entity.text.include?(val)
    end
  end
end
