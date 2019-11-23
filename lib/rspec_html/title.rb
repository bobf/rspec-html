# frozen_string_literal: true

module RSpecHTML
  # HTML/HEAD/TITLE abstraction
  class Title
    include Searchable
    include Nameable

    def initialize(parsed_html)
      @name = :title
      @entity = parsed_html.css('head title')
    end
  end
end
