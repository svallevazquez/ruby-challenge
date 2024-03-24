# frozen_string_literal: true

shared_context "segment default wrong values" do
  describe "origin field" do
    it_behaves_like "not valid model", test_description: "cannot be nil", error: "origin is not valid" do
      let(:origin) { nil }
    end

    it_behaves_like "not valid model", test_description: "cannot be lesser than 3 letters",
                                       error: "origin is not valid" do
      let(:origin) { "BG" }
    end

    it_behaves_like "not valid model", test_description: "cannot be upper than 3 letters",
                                       error: "origin is not valid" do
      let(:origin) { "BCNG" }
    end
  end

  describe "from_time field" do
    it_behaves_like "not valid model", test_description: "cannot be nil", error: "from_time is not valid" do
      let(:from_time) { nil }
    end

    it_behaves_like "not valid model", test_description: "only can be Time", error: "from_time is not valid" do
      let(:from_time) { Time.now.to_s }
    end
  end

  describe "to_time field" do
    it_behaves_like "not valid model", test_description: "cannot be nil", error: "to_time is not valid" do
      let(:to_time) { nil }
    end

    it_behaves_like "not valid model", test_description: "only can be Time", error: "to_time is not valid" do
      let(:to_time) { Time.now.to_s }
    end

    it_behaves_like "not valid model", test_description: "cannot be lesser than from_time",
                                       error: "to_time cannot be lesser than from_time" do
      let(:to_time) { from_time - (3 * 3600) }
    end
  end
end
