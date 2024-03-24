# frozen_string_literal: true

RSpec.describe RubyChallenge::Trip do
  let(:segments) do
    [
      RubyChallenge::Segments::Flight.new(origin: "MAD", destination: "BCN", from_time: Time.new(2024, 3, 7, 8, 0, 0),
                                          to_time: Time.new(2024, 3, 7, 9, 30, 0)),
      RubyChallenge::Segments::Hotel.new(origin: "BCN", from_time: Time.new(2024, 3, 7, 23, 59, 0),
                                         to_time: Time.new(2024, 3, 10, 0, 0, 0)),
      RubyChallenge::Segments::Train.new(origin: "BCN", destination: "MAD",
                                         from_time: Time.new(2024, 3, 10, 20, 30, 0),
                                         to_time: Time.new(2024, 3, 10, 22, 10, 0))
    ]
  end

  subject { described_class.new(segments:) }

  context "all successful" do
    let(:expected_result) do
      <<~TXT
        TRIP to BCN
        Flight from MAD to BCN at 2024-03-07 08:00 to 09:30
        Hotel at BCN on 2024-03-07 to 2024-03-10
        Train from BCN to MAD at 2024-03-10 20:30 to 22:10
      TXT
    end

    describe "checking errors" do
      it "validated" do
        expect(subject.valid?).to be_truthy
      end

      it "no errors" do
        subject.valid?
        expect(subject.errors).to be_empty
      end
    end

    it "run error when call to_s" do
      expect(subject.to_s).to eq(expected_result)
    end
  end

  context "wrong values" do
    describe "segments field" do
      it_behaves_like "not valid model", test_description: "cannot be nil", error: "segments is not valid" do
        let(:segments) { nil }
      end

      it_behaves_like "not valid model", test_description: "should be array type",
                                         error: "segments is not valid" do
        let(:segments) do
          RubyChallenge::Segments::Flight.new(origin: "MAD", destination: "BCN",
                                              from_time: Time.new(2024, 3, 7, 8, 0, 0),
                                              to_time: Time.new(2024, 3, 7, 9, 30, 0))
        end
      end

      it_behaves_like "not valid model", test_description: "cannot be empty",
                                         error: "segments is not valid" do
        let(:segments) { [] }
      end
    end
  end
end
