# frozen_string_literal: true

module RSpecHTML
  # HTML/BODY abstraction
  class Head
    include Nameable
    include Searchable

    def initialize(parsed_html)
      @parsed_html = parsed_html
      @entity = parsed_html.css('head')
      @name = :head
    end

    def title
      Title.new(@parsed_html)
    end

    def include?(val)
      title.include?(val)
    end
  end
end
