# frozen_string_literal: true

RSpec.describe RubyChallenge::Segments::Base do
  let(:origin) { "BCN" }
  let(:from_time) { Time.now }
  let(:to_time) { Time.now + (3 * 3600) }

  subject { described_class.new(origin:, from_time:, to_time:) }

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
    include_context "segment default wrong values"
  end
end
