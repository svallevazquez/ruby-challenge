# frozen_string_literal: true

RSpec.describe RubyChallenge::Segments::Transport do
  let(:custom_departure) { DateTime.new(2024, 2, 1, 12, 0, 0) }
  let(:origin) { "BCN" }
  let(:destination) { "MAD" }
  let(:departure) { custom_departure }
  let(:arrival) { custom_departure + Rational(3, 24) }

  subject { described_class.new(origin:, destination:, departure:, arrival:) }

  context "all successful" do
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
      expect(subject.to_s).to eq("Transport from BCN to MAD at 2024-02-01 12:00 to 15:00")
    end
  end

  context "wrong values" do
    describe "origin field" do
    include_examples "not valid", "cannot be nil" do
        let(:origin) { nil }
      end

    include_examples "not valid", "cannot be lesser than 3 letters" do
        let(:origin) { "BG" }
      end

    include_examples "not valid", "cannot be upper than 3 letters" do
        let(:origin) { "BCNG" }
      end
    end

    describe "destination field" do
    include_examples "not valid", "cannot be nil" do
        let(:destination) { nil }
      end

    include_examples "not valid", "cannot be lesser than 3 letters" do
        let(:destination) { "BG" }
      end

    include_examples "not valid", "cannot be upper than 3 letters" do
        let(:destination) { "BCNG" }
      end
    end

    describe "departure field" do
    include_examples "not valid", "cannot be nil" do
        let(:departure) { nil }
      end

    include_examples "not valid", "only can be DateTime" do
        let(:departure) { DateTime.now.to_s }
      end
    end

    describe "arrival field" do
    include_examples "not valid", "cannot be nil" do
        let(:arrival) { nil }
      end

    include_examples "not valid", "only can be DateTime" do
        let(:arrival) { DateTime.now.to_s }
      end

    include_examples "not valid", "cannot be lesser than departure" do
        let(:arrival) { departure - Rational(3, 24) }
      end
    end
  end
end
