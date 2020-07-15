# frozen_string_literal: true

module RSpecHTML
  # Mixin module providing methods for searching text content of HTML entities
  module Searchable
    def include?(val)
      @entity.text.include?(val)
    end

    def css(*args)
      @entity.css(*args)
    end

    def xpath(*args)
      @entity.xpath(*args)
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
      @entity.text.strip
    end

    def inspect
      %("#{self}")
    end
  end
end
