# frozen_string_literal: true

RSpec.describe RubyChallenge::Segments::Base do
  let(:origin) { "BCN" }
  let(:departure) { DateTime.now }
  let(:arrival) { DateTime.now + Rational(3, 24) }

  subject { described_class.new(origin:, departure:, arrival:) }

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
      expect { subject.to_s }.to raise_error(NotImplementedError)
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
