# frozen_string_literal: true

module RubyChallenge
  module Segments
    class Transport < Base
      attr_reader :destination

      def initialize(origin:, departure:, arrival:, destination:)
        super(origin:, departure:, arrival:)
        @destination = destination
      end

      def to_s
        departure_text = @departure.strftime("%Y-%m-%d %H:%M")
        arrival_text = @arrival.strftime("%H:%M")
        parsed_class = self.class.name.split("::").last
        "#{parsed_class} from #{@origin} to #{@destination} at #{departure_text} to #{arrival_text}"
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
