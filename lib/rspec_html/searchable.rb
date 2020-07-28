# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods for searching text content of HTML entities
  module Searchable
    def include?(val)
      @element.text.include?(val)
    end

    def css(*args)
      @element&.css(*args)
    end

    def xpath(*args)
      @element&.xpath(*args)
    end

    # rubocop:disable Naming/PredicateName
    def has_css?(*args)
      !css(*args).empty?
    end

    def has_xpath?(*args)
      !xpath(*args).empty?
    end
    # rubocop:enable Naming/PredicateName

    def to_s
      @element.text.strip
    end

    def inspect
      %("#{@element}")
    end

    def [](val)
      @element&.attr(val.to_s)
    end

    private

    def method_missing(tag, *args)
      return super unless Tags.include?(tag)
      return self.class.new(find(tag), tag) if args.empty?

      self.class.new(where(tag, args.first), tag)
    end

    def where(tag, query)
      xpath("//#{tag}[#{where_conditions(query)}]")&.first
    end

    def where_conditions(query)
      query.map do |key, value|
        %(@#{key}="#{value}")
      end.join ' and '
    end

    def find(tag)
      css(tag.to_s)&.first
    end

    def respond_to_missing?(method_name, *_)
      Tags.include?(method_name)
    end
  end
end
