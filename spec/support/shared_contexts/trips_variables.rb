# frozen_string_literal: true

shared_context "trips variables" do
  let(:first_segments) do
    [
      RubyChallenge::Segments::Flight.new(origin: "SVQ", destination: "BCN",
                                          from_time: Time.new(2023, 1, 5, 20, 40, 0),
                                          to_time: Time.new(2023, 1, 5, 22, 10, 0)),
      RubyChallenge::Segments::Hotel.new(origin: "BCN", from_time: Time.new(2023, 1, 5, 23, 59, 0),
                                         to_time: Time.new(2023, 1, 10, 0, 0, 0)),
      RubyChallenge::Segments::Flight.new(origin: "BCN", destination: "SVQ",
                                          from_time: Time.new(2023, 1, 10, 10, 30, 0),
                                          to_time: Time.new(2023, 1, 10, 11, 50, 0))
    ]
  end
  let(:first_trip) do
    RubyChallenge::Trip.new(segments: first_segments)
  end

  let(:second_segments) do
    [
      RubyChallenge::Segments::Train.new(origin: "SVQ", destination: "MAD",
                                         from_time: Time.new(2023, 2, 15, 9, 30, 0),
                                         to_time: Time.new(2023, 2, 15, 11, 0o0, 0)),
      RubyChallenge::Segments::Hotel.new(origin: "MAD", from_time: Time.new(2023, 2, 15, 23, 59, 0),
                                         to_time: Time.new(2023, 2, 17, 0, 0, 0)),
      RubyChallenge::Segments::Train.new(origin: "MAD", destination: "SVQ",
                                         from_time: Time.new(2023, 2, 17, 17, 0o0, 0),
                                         to_time: Time.new(2023, 2, 17, 19, 30, 0))
    ]
  end
  let(:second_trip) do
    RubyChallenge::Trip.new(segments: second_segments)
  end

  let(:third_segments) do
    [
      RubyChallenge::Segments::Flight.new(origin: "SVQ", destination: "BCN",
                                          from_time: Time.new(2023, 3, 2, 6, 40, 0),
                                          to_time: Time.new(2023, 3, 2, 9, 10, 0)),
      RubyChallenge::Segments::Flight.new(origin: "BCN", destination: "NYC",
                                          from_time: Time.new(2023, 3, 2, 15, 0, 0),
                                          to_time: Time.new(2023, 3, 2, 22, 45, 0))
    ]
  end
  let(:third_trip) do
    RubyChallenge::Trip.new(segments: third_segments)
  end

  let(:demo_filepath) { "test_files/demo_input.txt" }
  let(:trips_for_demo) { [first_trip, second_trip, third_trip] }
end
