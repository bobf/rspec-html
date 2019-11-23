# frozen_string_literal: true

module RSpecHTML
  # HTML/BODY abstraction
  class Body
    include Searchable
    include Nameable

    def initialize(parsed_html)
      @name = :body
      @entity = parsed_html.css('body')
    end
  end
end
