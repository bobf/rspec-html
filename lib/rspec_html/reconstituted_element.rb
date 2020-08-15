# frozen_string_literal: true

module RSpecHTML
  # Reconstructs an HTML representation of an element from provided parameters.
  class ReconstitutedElement
    def initialize(tag, options)
      @tag = tag
      @options = options
    end

    def to_s
      name = @tag.to_s.downcase
      return '#document' if name == 'document'
      return name if name == 'document'
      return "<#{name}#{formatted_attributes} />" unless @options&.key?(:text)

      "<#{name}#{formatted_attributes}>#{@options[:text]}</#{name}>"
    end

    private

    def mapped_attributes
      return [] if @options.nil?

      @options.reject { |key| key.to_sym == :text }.map do |key, value|
        next %(#{key}="#{value}") unless key.to_sym == :class && value.is_a?(Array)

        %(#{key}="#{value.join(' ')}")
      end
    end

    def formatted_attributes
      mapped_attributes.empty? ? nil : " #{mapped_attributes.join(' ')}"
    end
  end
end
