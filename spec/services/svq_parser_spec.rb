# frozen_string_literal: true

RSpec.describe RubyChallenge::SvqParser do
  subject { described_class.new(svq_filepath:).call }

  context "all successful" do
    include_context "trips variables"

    let(:svq_filepath) { File.expand_path("../#{demo_filepath}", __dir__) }

    it "returning the trips" do
      trips_for_demo.each_with_index do |trip, trip_index|
        expect(subject[trip_index]).to have_attributes(
          beginning: trip.beginning,
          destination: trip.destination
        )
        trip.segments.each_with_index do |segment, segment_index|
          expect(subject[trip_index].segments[segment_index]).to have_attributes(
            class: segment.class,
            origin: segment.origin,
            from_time: segment.from_time,
            to_time: segment.to_time
          )
        end
      end
    end
  end

  context "wrong values" do
    describe "invalid filepath" do
      let(:svq_filepath) { "testing_invalid_filepath.txt" }

      it "returns an error of filepath doesn't exist" do
        expect { subject }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
