# frozen_string_literal: true

module RSpecHTML
  # DSL module for all matchers, provides element counting utilities.
  module Countable
    def once
      @expected_count = 1
      @expected_count_type ||= :exact
      self
    end

    def twice
      @expected_count = 2
      @expected_count_type ||= :exact
      self
    end

    def times(count)
      @expected_count = count
      @expected_count_type ||= :exact
      self
    end

    def at_least(count = nil)
      @expected_count = { once: 1, twice: 2 }.fetch(count, nil)
      @expected_count_type = :at_least
      self
    end

    def at_most(count = nil)
      @expected_count = { once: 1, twice: 2 }.fetch(count, nil)
      @expected_count_type = :at_most
      self
    end

    private

    def count_match?
      case @expected_count_type
      when :exact
        @actual_count == @expected_count
      when :at_least
        @actual_count >= @expected_count
      when :at_most
        @actual_count <= @expected_count
      else
        raise ArgumentError, 'Unknown count comparison type'
      end
    end
  end
end
