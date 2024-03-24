# frozen_string_literal: true

shared_context "transport segment model" do
  let(:custom_from_time) { Time.new(2024, 2, 1, 12, 0, 0) }
  let(:origin) { "BCN" }
  let(:destination) { "MAD" }
  let(:from_time) { custom_from_time }
  let(:to_time) { custom_from_time + (3 * 3600) }

  subject { described_class.new(origin:, destination:, from_time:, to_time:) }

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
      parsed_class = described_class.name.split("::").last
      expect(subject.to_s).to eq("#{parsed_class} from BCN to MAD at 2024-02-01 12:00 to 15:00")
    end
  end

  context "wrong values" do
    include_context "segment default wrong values"

    describe "destination field" do
      it_behaves_like "not valid model", test_description: "cannot be nil", error: "destination is not valid" do
        let(:destination) { nil }
      end

      it_behaves_like "not valid model", test_description: "cannot be lesser than 3 letters",
                                         error: "destination is not valid" do
        let(:destination) { "MD" }
      end

      it_behaves_like "not valid model", test_description: "cannot be upper than 3 letters",
                                         error: "destination is not valid" do
        let(:destination) { "MADG" }
      end

      it_behaves_like "not valid model", test_description: "cannot be the same as origin",
                                         error: "destination cannot be the same as origin" do
        let(:destination) { "BCN" }
      end
    end
  end
end
