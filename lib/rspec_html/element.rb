# frozen_string_literal: true

module RSpecHTML
  # HTML DOM element abstraction
  class Element
    include Searchable
    include Nameable

    def initialize(element, name)
      @name = name
      @element = element
    end
  end
end
