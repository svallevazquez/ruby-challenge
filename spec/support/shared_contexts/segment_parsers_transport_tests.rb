# frozen_string_literal: true

shared_context "segment parsers transport tests" do
  subject { described_class.new(words:).call }

  context "all successful" do
    let(:current_class) { described_class.name.split("::").last }

    shared_examples_for "returns expected segment" do
      it "returns expected segment" do
        expect(subject).to have_attributes(
          class: Object.const_get("RubyChallenge::Segments::#{current_class}"),
          origin: expected_result.origin,
          destination: expected_result.destination,
          from_time: expected_result.from_time,
          to_time: expected_result.to_time
        )
      end
    end

    describe "normal behaviour" do
      let(:words) { %w[BCN 2023-01-05 10:30 SVQ 12:40] }
      let(:expected_result) do
        Object.const_get("RubyChallenge::Segments::#{current_class}")
              .new(origin: "BCN", destination: "SVQ",
                   from_time: Time.new(2023, 1, 5, 10, 30), to_time: Time.new(2023, 1, 5, 12, 40))
      end

      it_behaves_like "returns expected segment"
    end

    describe "jump of one day" do
      let(:words) { %w[BCN 2023-01-05 10:30 SVQ 05:40] }
      let(:expected_result) do
        Object.const_get("RubyChallenge::Segments::#{current_class}")
              .new(origin: "BCN", destination: "SVQ",
                   from_time: Time.new(2023, 1, 5, 10, 30), to_time: Time.new(2023, 1, 6, 0o5, 40))
      end

      it_behaves_like "returns expected segment"
    end
  end

  context "wrong values" do
    describe "invalid origin" do
      let(:words) { %w[BC 2023-01-05 10:30 SVQ 12:40] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingSegmentError)
      end
    end

    describe "invalid destination" do
      let(:words) { %w[BCN 2023-01-05 10:30 SV 12:40] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingSegmentError)
      end
    end

    describe "invalid from_time" do
      let(:words) { %w[BCN 2023-99-05 10:30 SVQ 12:40] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingDateTimeError)
      end
    end

    describe "invalid to_time" do
      let(:words) { %w[BCN 2023-01-05 10:30 SVQ 99:40] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingDateTimeError)
      end
    end
  end
end
