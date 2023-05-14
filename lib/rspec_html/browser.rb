# frozen_string_literal: true

module RSpecHTML
  # Convenience utility for loading a provided path in the operating system's default browser.
  # Used for inspecting documents while debugging tests.
  class Browser
    def self.open(path)
      new(path).open
    end

    def initialize(path)
      @path = path
    end

    def open
      log_launch_browser_event
      system `#{command} '#{path}'`
    end

    private

    attr_reader :path

    def log_launch_browser_event
      warn "\e[35m[rspec-html] Opening document in browser from: \e[32m#{caller[3]}\e[0m"
    end

    def command
      return 'start' if RUBY_PLATFORM =~ /mswin|mingw|cygwin/
      return 'open' if RUBY_PLATFORM =~ /darwin/
      return 'xdg-open' if RUBY_PLATFORM =~ /linux|bsd/

      raise ArgumentError, "Unable to detect operating system from #{RUBY_PLATFORM}"
    end
  end
end
