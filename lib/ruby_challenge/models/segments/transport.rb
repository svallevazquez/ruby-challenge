# frozen_string_literal: true

module RubyChallenge
  module Segments
    class Transport < Base
      attr_reader :destination

      def initialize(origin:, destination:, from_time:, to_time:)
        super(origin:, from_time:, to_time:)
        @destination = destination
      end

      def to_s
        from_time_text = @from_time.strftime("%Y-%m-%d %H:%M")
        to_time_text = @to_time.strftime("%H:%M")
        parsed_class = self.class.name.split("::").last
        "#{parsed_class} from #{@origin} to #{@destination} at #{from_time_text} to #{to_time_text}"
      end

      def check_errors
        super
        @errors << "destination is not valid" if @destination.nil? || @destination.length != 3
        return if @origin.nil? || @destination.nil?

        @errors << "destination cannot be the same as origin" if @origin == @destination
      end
    end
  end
end
