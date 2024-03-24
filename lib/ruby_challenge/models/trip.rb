# frozen_string_literal: true

module RubyChallenge
  class Trip
    attr_reader :segments, :errors

    def initialize(segments:)
      @segments = segments
      @errors = []
    end

    def valid?
      @errors << "segments is not valid" if !@segments.is_a?(Array) || @segments.empty?
      @errors.empty?
    end

    def to_s
      result = "TRIP to #{find_destination}\n"
      segments.each { |segment| result += "#{segment}\n" }
      result
    end

    private

    def find_destination
      hotel = @segments.find { |segment| segment.is_a?(RubyChallenge::Segments::Hotel) }
      return hotel.origin if hotel

      @segments.map(&:destination).unique.last
    end
  end
end
