# frozen_string_literal: true

module RubyChallenge
  class Trip
    attr_reader :segments, :beginning, :destination, :errors

    def initialize(segments:, beginning:, destination:)
      @segments = segments
      @beginning = beginning
      @destination = destination
      @errors = []
    end

    def valid?
      @errors << "segments is not valid" if !@segments.is_a?(Array) || @segments.empty?
      @errors << "beginning is not valid" if @beginning.nil? || !@beginning.is_a?(Time)
      @errors << "destination is not valid" if @destination.nil? || @destination.length != 3
      @errors.empty?
    end

    def to_s
      result = "TRIP to #{destination}\n"
      segments.each { |segment| result += "#{segment}\n" }
      result
    end
  end
end
