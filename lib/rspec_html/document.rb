# frozen_string_literal: true

module RSpecHTML
  # HTML Document representation
  class Document
    def initialize(html)
      @html = html
    end

    # rubocop:disable Naming/PredicateName
    def has_xpath?(*args)
      !parsed_html.xpath(*args).empty?
    end

    def has_css?(*args)
      !parsed_html.css(*args).empty?
    end
    # rubocop:enable Naming/PredicateName

    def body
      Body.new(parsed_html)
    end

    def head
      Head.new(parsed_html)
    end

    private

    def parsed_html
      @parsed_html ||= Nokogiri::HTML(@html)
    end
  end
end
