# frozen_string_literal: true

module RubyChallenge
  module Segments
    class Hotel < Base
      def to_s
        from_time_text = @from_time.strftime("%Y-%m-%d")
        to_time_text = @to_time.strftime("%Y-%m-%d")
        "Hotel at #{@origin} on #{from_time_text} to #{to_time_text}"
      end
    end
  end
end
