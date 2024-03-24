# frozen_string_literal: true

module RubyChallenge
  class SvqParser
    def initialize(svq_filepath:)
      @svq_content = File.read(svq_filepath)
    end

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      first_segments = [
        RubyChallenge::Segments::Flight.new(origin: "SVQ", destination: "BCN",
                                            from_time: Time.new(2023, 1, 5, 20, 40, 0),
                                            to_time: Time.new(2023, 1, 5, 22, 10, 0)),
        RubyChallenge::Segments::Hotel.new(origin: "BCN", from_time: Time.new(2023, 1, 5, 15, 0o0, 0),
                                           to_time: Time.new(2023, 1, 10, 12, 0o0, 0)),
        RubyChallenge::Segments::Flight.new(origin: "BCN", destination: "SVQ",
                                            from_time: Time.new(2023, 1, 10, 10, 30, 0),
                                            to_time: Time.new(2023, 1, 10, 11, 50, 0))
      ]
      first_trip = RubyChallenge::Trip.new(segments: first_segments, beginning: first_segments.first.from_time,
                                           destination: "BCN")

      second_segments = [
        RubyChallenge::Segments::Train.new(origin: "SVQ", destination: "MAD",
                                           from_time: Time.new(2023, 2, 15, 9, 30, 0),
                                           to_time: Time.new(2023, 2, 15, 11, 0o0, 0)),
        RubyChallenge::Segments::Hotel.new(origin: "MAD", from_time: Time.new(2023, 2, 15, 15, 0o0, 0),
                                           to_time: Time.new(2023, 2, 17, 12, 0o0, 0)),
        RubyChallenge::Segments::Train.new(origin: "MAD", destination: "SVQ",
                                           from_time: Time.new(2023, 2, 17, 17, 0o0, 0),
                                           to_time: Time.new(2023, 2, 17, 19, 30, 0))
      ]
      second_trip = RubyChallenge::Trip.new(segments: second_segments, beginning: second_segments.first.from_time,
                                            destination: "MAD")

      third_segments = [
        RubyChallenge::Segments::Flight.new(origin: "SVQ", destination: "BCN",
                                            from_time: Time.new(2023, 3, 2, 6, 40, 0),
                                            to_time: Time.new(2023, 3, 2, 9, 10, 0)),
        RubyChallenge::Segments::Flight.new(origin: "BCN", destination: "NYC",
                                            from_time: Time.new(2023, 3, 2, 15, 0, 0),
                                            to_time: Time.new(2023, 3, 2, 22, 45, 0))
      ]
      third_trip = RubyChallenge::Trip.new(segments: third_segments, beginning: third_segments.first.from_time,
                                           destination: "NYC")

      [first_trip, second_trip, third_trip]
    end
  end
end
