# frozen_string_literal: true

module RSpecHTML
  # HTML DOM element abstraction
  class Element
    include Searchable

    attr_reader :name, :element

    def initialize(element, name, options: {}, siblings: [])
      @name = name
      @element = element
      @options = options
      @siblings = siblings
    end

    def inspect
      "<#{self.class}::#{name.to_s.capitalize}>"
    end

    def to_s
      @element.to_s
    end

    def reconstituted
      self.class.reconstituted(name, @options)
    end

    def self.reconstituted(tag, options = {})
      ReconstitutedElement.new(tag, options).to_s
    end
  end
end
