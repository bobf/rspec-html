# frozen_string_literal: true

module RSpecHTML
  # HTML DOM element abstraction
  class Element
    attr_reader :name, :element, :search

    extend Forwardable

    def_delegators :@search,
                   :has_css?, :has_xpath?, :include?,
                   :all, :siblings, :text, :truncated_text, :attributes, :to_a,
                   :size, :length, :[],
                   :css, :xpath, :checked?,
                   :first, :last, :second, :third, :fourth, :fifth

    def initialize(element, name, options: {}, siblings: [])
      @name = name
      @element = element
      @options = options
      @siblings = siblings || []
      @search = Search.new(@element, @siblings, self)
    end

    def open
      Browser.open(html_path)
    end

    def html_path
      @html_path ||= Pathname.new(Dir.mktmpdir('rspec-html')).join('document.html').tap do |path|
        path.write(@element.inner_html)
      end
    end

    def present?
      return true if name == :document

      @search.present?
    end
    alias exist? present?

    def inspect
      reconstituted
    end

    def to_s
      @element.to_s
    end

    Tags.each do |tag|
      define_method tag.downcase do |*args|
        args[0] = " #{args[0]}" if args.first.is_a?(String) && args.first&.match?(/^[a-zA-Z]/)
        options = args.first
        return @search.new_from_find(tag.downcase, options) if options.nil?

        @search.new_from_where(tag.downcase, options)
      end
    end

    def reconstituted
      self.class.reconstituted(name, @options)
    end

    def self.reconstituted(tag, options = {})
      ReconstitutedElement.new(tag, options).to_s
    end
  end
end
