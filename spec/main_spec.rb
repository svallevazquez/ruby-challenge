# frozen_string_literal: true

RSpec.describe "main.rb" do
  context "expected behavior" do
    describe "with default script" do
      let(:command) { `BASED=SVQ bundle exec ruby main.rb input.txt` }
      let(:expected_output_filepath) { File.expand_path("test_files/result_default_input.txt", __dir__) }
      let(:expected_output_file) { File.read(expected_output_filepath) }

      it "matched with expected output file" do
        expect(command).to eq(expected_output_file)
      end
    end
  end
end
