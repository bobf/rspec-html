# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods for searching text content of HTML entities
  module Searchable
    def include?(val)
      text.include?(val)
    end

    def css(*args)
      self.class.new(@element&.css(*args), :css)
    end

    def xpath(*args)
      self.class.new(@element&.xpath(*args), :xpath)
    end

    def present?
      !@element.nil?
    end
    alias exist? present?

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
      @element&.text&.gsub('\s+', ' ')&.strip || ''
    end

    def size
      return @element.size if @element.respond_to?(:size)

      @siblings.size
    end
    alias length size

    private

    def method_missing(tag, *args)
      options = args.first
      return super unless Tags.include?(tag)
      return new_from_find(tag, options) if options.nil?

      new_from_where(tag, options)
    end

    def new_from_find(tag, options)
      self.class.new(
        find(tag),
        tag,
        options: options,
        siblings: find(tag, all: true)
      )
    end

    def new_from_where(tag, options)
      self.class.new(
        where(tag, options),
        tag,
        options: options,
        siblings: where(tag, options, all: true)
      )
    end

    def index(val)
      zero_index_error if val.zero?
      self.class.new(@siblings[val - 1], name)
    end

    def range(val)
      zero_index_error if val.first.zero?
      self.class.new(@siblings[(val.first - 1)..(val.last - 1)], :range)
    end

    def zero_index_error
      raise ArgumentError, 'Index for matched sets starts at 1, not 0.'
    end

    def where(tag, query, all: false)
      matched = if query[:class]
                  where_class(tag, query[:class]) & where_xpath(tag, query.merge(class: nil))
                else
                  where_xpath(tag, query)
                end
      return matched&.first unless all

      matched
    end

    def where_xpath(tag, query)
      conditions = "[#{where_conditions(query)}]" unless query.compact.empty?
      @element&.xpath("//#{tag}#{conditions}")
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

    # rubocop:disable Lint/MissingSuper
    def respond_to_missing?(method_name, *_)
      Tags.include?(method_name)
    end
    # rubocop:enable Lint/MissingSuper
  end
end
