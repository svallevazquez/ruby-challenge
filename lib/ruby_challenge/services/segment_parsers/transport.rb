# frozen_string_literal: true

module RubyChallenge
  module SegmentParsers
    class Transport < Base
      CONFIG = {
        origin: { position: 0, type: :string },
        from_time: { position: [1, 2], type: :time },
        destination: { position: 3, type: :string },
        to_time: { position: 4, type: :clock_time }
      }.freeze

      def initialize(words:)
        super(words:)
        @config = CONFIG
      end

      protected

      def create_segment
        parsed_klass = self.class.name.split("::").last
        from_time = field_value(:from_time)
        Object.const_get("RubyChallenge::Segments::#{parsed_klass}").new(
          origin: field_value(:origin),
          destination: field_value(:destination),
          from_time:,
          to_time: field_value(:to_time, base_time: from_time)
        )
      end

      def parse_clock_time(position, extra_config)
        clock_time_text = @words[position]
        base_time = extra_config[:base_time]
        time_text = "#{base_time.strftime("%Y-%m-%d")} #{clock_time_text}"
        target_time = convert_text_to_time(time_text)
        target_time += 24 * 3600 if target_time < base_time
        target_time
      end
    end
  end
end
