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

    def self.reconstituted(tag, options = {})
      name = tag.to_s.downcase
      mapped_attributes = options.reject { |key| key.to_sym == :text }.map do |key, value|
        next %(#{key}="#{value}") unless key.to_sym == :class && value.is_a?(Array)

        %(#{key}="#{value.join(' ')}")
      end

      attributes = mapped_attributes.empty? ? nil : " #{mapped_attributes.join(' ')}"
      return "<#{name}#{attributes} />" unless options.key?(:text)

      "<#{name}#{attributes}>#{options[:text]}</#{name}>"
    end
  end
end
