# frozen_string_literal: true

module RubyChallenge
  module Segments
    class Base
      attr_reader :origin, :from_time, :to_time, :errors

      def initialize(origin:, from_time:, to_time:)
        @origin = origin
        @from_time = from_time
        @to_time = to_time
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
        check_errors_for_datetimes
      end

      private

      def check_errors_for_datetimes
        @errors << "from_time is not valid" if @from_time.nil? || !@from_time.is_a?(Time)
        @errors << "to_time is not valid" if @to_time.nil? || !@to_time.is_a?(Time)
        return if !@to_time.is_a?(Time) || !@from_time.is_a?(Time)

        @errors << "to_time cannot be lesser than from_time" if @to_time < @from_time
      end
    end
  end
end
