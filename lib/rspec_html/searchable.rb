# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods for searching text content of HTML entities
  module Searchable
    def include?(val)
      @element.text.include?(val)
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

    def to_s
      @element&.text&.strip
    end

    def inspect
      %("#{@element}")
    end

    def [](val)
      return index(val) if val.is_a?(Integer)
      return range(val) if val.is_a?(Range)

      @element&.attr(val.to_s)
    end

    def size
      return @element.size if @element.respond_to?(:size)

      @siblings.size
    end
    alias length size

    private

    def method_missing(tag, *args)
      return super unless Tags.include?(tag)
      return self.class.new(find(tag), tag, siblings: find(tag, all: true)) if args.empty?

      self.class.new(where(tag, args.first), tag, siblings: where(tag, args.first, all: true))
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
      matched = @element&.xpath("//#{tag}[#{where_conditions(query)}]")
      return matched&.first unless all

      matched
    end

    def where_conditions(query)
      query.map do |key, value|
        %(@#{key}="#{value}")
      end.join ' and '
    end

    def find(tag, all: false)
      return @element&.css(tag.to_s)&.first unless all

      @element&.css(tag.to_s)
    end

    def respond_to_missing?(method_name, *_)
      Tags.include?(method_name)
    end
  end
end
