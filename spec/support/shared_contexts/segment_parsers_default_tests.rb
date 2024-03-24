# frozen_string_literal: true

shared_context "segment parsers default tests" do
  let(:current_class) { described_class.name.split("::").last }
  let(:words) { %w[BCN 2023-01-05 2023-01-10] }
  let(:expected_result) do
    Object.const_get("RubyChallenge::Segments::#{current_class}")
          .new(origin: "BCN", from_time: Time.new(2023, 1, 5), to_time: Time.new(2023, 1, 10))
  end

  subject { described_class.new(words:).call }

  context "all successful" do
    it "returns expected segment" do
      expect(subject).to have_attributes(
        class: Object.const_get("RubyChallenge::Segments::#{current_class}"),
        origin: expected_result.origin,
        from_time: expected_result.from_time,
        to_time: expected_result.to_time
      )
    end
  end

  context "wrong values" do
    describe "invalid origin" do
      let(:words) { %w[BC 2023-01-05 2023-01-10] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingSegmentError)
      end
    end

    describe "invalid from_time" do
      let(:words) { %w[BCN 2023-99-05 2023-01-10] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingDateTimeError)
      end
    end

    describe "invalid to_time" do
      let(:words) { %w[BCN 2023-99-05 2023-01-10] }

      it "returns custom error" do
        expect { subject }.to raise_error(RubyChallenge::SegmentParsers::ParsingDateTimeError)
      end
    end
  end
end
