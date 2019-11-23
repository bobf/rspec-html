# frozen_string_literal: true

module RSpecHTML
  # HTML Document representation
  class Document
    def initialize(html)
      @html = html
    end

    def body
      Body.new(parsed_html)
    end

    private

    def parsed_html
      @parsed_html ||= Nokogiri::HTML(@html)
    end
  end
end
