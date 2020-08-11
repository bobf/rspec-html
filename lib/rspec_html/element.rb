# frozen_string_literal: true

module RSpecHTML
  # HTML DOM element abstraction
  class Element
    include Searchable

    attr_reader :name, :element

    def initialize(element, name, siblings: [])
      @name = name
      @element = element
      @siblings = siblings
    end

    def inspect
      "<#{self.class}::#{name.to_s.capitalize}>"
    end

    def to_s
      @element.to_s
    end
  end
end
