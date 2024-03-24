# frozen_string_literal: true

module RubyChallenge
  class SvqParser
    SEGMENT_LINE_IDENTIFIER = "SEGMENT: "
    UNNECESSARY_TEXT = " ->"
    DAY_TIME = 3600 * 24

    def initialize(svq_filepath:)
      @svq_content = File.read(svq_filepath).gsub(/^$\n/, "")
    end

    def call
      segments = create_segments_from_file
      # Sort segments by from_time
      segments = segments.sort_by(&:from_time)
      # Organize segments
      segments_per_trip = organize_segments(segments)
      # Create trips
      segments_per_trip.map { RubyChallenge::Trip.new(segments: _1) }
    end

    private

    def create_segments_from_file
      segments = []
      @svq_content.each_line do |line|
        next if line.include?("RESERVATION")

        parsed_line = line.gsub(SEGMENT_LINE_IDENTIFIER, "").gsub(UNNECESSARY_TEXT, "")
        segments << segment_parser(parsed_line)
      end
      segments
    end

    def segment_parser(parsed_line)
      words = parsed_line.split
      klass_for_parser = words.shift
      Object.const_get("RubyChallenge::SegmentParsers::#{klass_for_parser}").new(words:).call
    end

    def organize_segments(segments)
      result = []
      previous_segment = segments.shift
      segments_per_trip = [previous_segment]

      segments.each do |current_segment|
        if usual_segments_connection?(previous_segment, current_segment) ||
           flight_segments_connection?(previous_segment, current_segment)
          segments_per_trip << current_segment
          previous_segment = current_segment
          next
        end

        result << segments_per_trip
        segments_per_trip = [current_segment]
        previous_segment = current_segment
      end
      result << segments_per_trip if segments_per_trip.any?
      result
    end

    def usual_segments_connection?(previous_segment, current_segment)
      same_date = previous_segment.to_time.to_date == current_segment.from_time.to_date
      connection_between_places?(previous_segment, current_segment) && same_date
    end

    def flight_segments_connection?(previous_segment, current_segment)
      both_flights = current_segment.is_a?(RubyChallenge::Segments::Flight) &&
                     previous_segment.is_a?(RubyChallenge::Segments::Flight)
      both_flights && connection?(previous_segment, current_segment) &&
        difference_lesser_than_one_day?(previous_segment, current_segment)
    end

    def difference_lesser_than_one_day?(previous_segment, current_segment)
      difference = current_segment.from_time - previous_segment.to_time
      difference < DAY_TIME
    end

    def connection_between_places?(previous_segment, current_segment)
      return previous_segment.origin == current_segment.origin unless previous_segment.respond_to?(:destination)

      previous_segment.destination == current_segment.origin
    end
  end
end
