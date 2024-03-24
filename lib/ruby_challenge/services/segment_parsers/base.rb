# frozen_string_literal: true

require "time"

module RubyChallenge
  module SegmentParsers
    class ParsingSegmentError < StandardError; end
    class ParsingDateTimeError < StandardError; end

    class Base
      CONFIG = {
        origin: { position: 0, type: :string },
        from_time: { position: 1, type: :time },
        to_time: { position: 2, type: :time }
      }.freeze

      def initialize(words:)
        @words = words
        @config = CONFIG
      end

      def call
        segment = create_segment
        check_segment_errors(segment)
        segment
      end

      protected

      def create_segment
        parsed_klass = self.class.name.split("::").last
        Object.const_get("RubyChallenge::Segments::#{parsed_klass}").new(
          origin: field_value(:origin),
          from_time: field_value(:from_time),
          to_time: field_value(:to_time)
        )
      end

      def check_segment_errors(segment)
        raise ParsingSegmentError, "Errors parging segment #{segment.inspect}" unless segment.valid?
      end

      def field_value(field, extra_config = {})
        field_config = @config[field]
        position = field_config[:position]

        case field_config[:type]
        when :string
          @words[position]
        else
          send("parse_#{field_config[:type]}", position, extra_config)
        end
      end

      def parse_time(position, _extra_config)
        time_text = if position.is_a?(Array)
                      position.map { @words[_1] }.join(" ")
                    else
                      "#{@words[position]} 00:00"
                    end
        convert_text_to_time(time_text)
      end

      def convert_text_to_time(time_text)
        Time.strptime(time_text, "%Y-%m-%d %H:%M")
      rescue ArgumentError
        raise ParsingDateTimeError, "Invalid datetime from text '#{time_text}'"
      end
    end
  end
end
