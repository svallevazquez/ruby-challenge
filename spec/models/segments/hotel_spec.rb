# frozen_string_literal: true

RSpec.describe RubyChallenge::Segments::Hotel do
  let(:custom_from_time) { Time.new(2024, 2, 1, 12, 0, 0) }
  let(:three_days) { 3 * 24 * 3600 }
  let(:origin) { "BCN" }
  let(:from_time) { custom_from_time }
  let(:to_time) { custom_from_time + three_days }

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
      expect(subject.to_s).to eq("Hotel at BCN on 2024-02-01 to 2024-02-04")
    end
  end

  context "wrong values" do
    include_context "segment default wrong values"
  end
end
