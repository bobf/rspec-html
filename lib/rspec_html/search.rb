# frozen_string_literal: true

module RSpecHTML
  # Provides element/attribute/text searching for HTML entities
  # rubocop:disable Metrics/ClassLength
  class Search
    attr_reader :siblings

    extend Forwardable

    def_delegators :to_a,
                   :first, :last, :second, :third, :fourth, :fifth

    def initialize(element, siblings, element_wrapper)
      @element = element
      @siblings = siblings
      @element_wrapper = element_wrapper
    end

    def to_s
      @element&.to_s
    end

    def to_a
      all.to_a
    end

    def include?(val)
      text.include?(val)
    end

    def css(*args)
      self.class.new(@element&.css(*args), :css, element_wrapper)
    end

    def xpath(*args)
      self.class.new(@element&.xpath(*args), :xpath, element_wrapper)
    end

    def present?
      !@element.nil?
    end
    alias exist? present?

    def checked?
      raise ElementNotFoundError, "Element does not exist: #{element_wrapper.reconstituted}" if @element.nil?

      @element.attributes.key?('checked')
    end

    def all
      return [] if @siblings.nil?

      @siblings.map { |sibling| Element.new(sibling, @element&.name) }
    end

    # rubocop:disable Naming/PredicateName
    def has_css?(*args)
      !@element&.css(*args)&.empty?
    end

    def has_xpath?(*args)
      !@element&.xpath(*args)&.empty?
    end
    # rubocop:enable Naming/PredicateName

    def [](val)
      return index(val) if val.is_a?(Integer)
      return range(val) if val.is_a?(Range)

      @element&.attr(val.to_s)
    end

    def text
      @element&.text&.gsub(/\s+/, ' ')&.strip || ''
    end

    def truncated_text
      max = RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length
      return text if text.size <= max

      "#{text[0..max]}...#{text[-max..-1]}"
    end

    def attributes
      @element&.attributes&.to_h { |key, val| [key.to_sym, val.to_s] } || {}
    end

    def size
      return @element.size if @element.respond_to?(:size)

      @siblings&.size || 0
    end
    alias length size

    def new_from_find(tag, options)
      Element.new(
        find(tag),
        tag,
        options: options,
        siblings: find(tag, all: true)
      )
    end

    def new_from_where(tag, options)
      Element.new(
        where(tag, options),
        tag,
        options: options,
        siblings: where(tag, options, all: true)
      )
    end

    private

    attr_reader :element_wrapper

    def index(val)
      zero_index_error if val.zero?
      Element.new(@siblings[val - 1], @element.name)
    end

    def range(val)
      zero_index_error if val.first.zero?
      @siblings[(val.first - 1)..(val.last - 1)].map { |element| Element.new(element, @element.name) }
    end

    def zero_index_error
      raise ArgumentError, 'Index for matched sets starts at 1, not 0.'
    end

    def where(tag, query, all: false)
      matched = matched_from_query(tag, query)
      return nil unless matched || all
      return matched&.first unless all

      matched
    end

    def matched_from_query(tag, query)
      if query.is_a?(String)
        @element&.css("#{tag}#{query}")
      elsif query[:class]
        where_class(tag, query[:class]) & where_xpath(tag, query.merge(class: nil))
      else
        where_xpath(tag, query)
      end
    end

    def where_xpath(tag, query)
      conditions = "[#{where_conditions(query)}]" unless query.compact.empty?
      result = @element&.xpath(".//#{tag}#{conditions}")
      return result unless @siblings.is_a?(Nokogiri::XML::NodeSet) && (result.nil? || result.empty?)

      @siblings.xpath(".//#{tag}#{conditions}")
    end

    def where_conditions(query)
      query.compact.map do |key, value|
        next if value.nil?
        next %(@#{key}="#{value}") unless key == :text

        %[contains(text(),"#{value}")]
      end.join ' and '
    end

    def where_class(tag, class_or_classes)
      classes = class_or_classes.is_a?(Array) ? class_or_classes : class_or_classes.to_s.split
      selector = classes.map(&:to_s).join('.')
      @element&.css("#{tag}.#{selector}")
    end

    def find(tag, all: false)
      return @element&.css(tag.to_s)&.first unless all

      @element&.css(tag.to_s)
    end
  end
  # rubocop:enable Metrics/ClassLength
end
