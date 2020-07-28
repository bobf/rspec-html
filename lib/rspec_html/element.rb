# frozen_string_literal: true

module RSpecHTML
  # HTML DOM element abstraction
  class Element
    include Searchable
    include Nameable

    def initialize(element, name, siblings: [])
      @name = name
      @element = element
      @siblings = siblings
    end
  end
end
