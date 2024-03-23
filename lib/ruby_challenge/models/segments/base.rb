# frozen_string_literal: true

module RubyChallenge
  module Segments
    class Base
      attr_reader :origin, :departure, :arrival, :errors

      def initialize(origin:, departure:, arrival:)
        @origin = origin
        @departure = departure
        @arrival = arrival
        @errors = []
      end

      def valid?
        check_errors
        @errors.empty?
      end

      def to_s = raise NotImplementedError, "You must implement this method into the subclass"

      protected

      def check_errors
        @errors << "origin is not valid" if @origin.nil? || @origin.length != 3
        @errors << "departure is not valid" if @departure.nil? || !@departure.is_a?(DateTime)
        @errors << "arrival is not valid" if @arrival.nil? || !@arrival.is_a?(DateTime)
        @errors << "arrival cannot be lesser than departure" if @arrival.is_a?(DateTime) && @departure.is_a?(DateTime) && @arrival < @departure
      end
    end
  end
end