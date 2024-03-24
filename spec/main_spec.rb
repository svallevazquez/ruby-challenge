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

  context "wrong inputs" do
    shared_examples_for "show error message" do |error_message:|
      it "show error message" do
        expect(command).to eq(error_message)
      end
    end

    describe "without BASED env variable" do
      it_behaves_like "show error message",
                      error_message: "Error: Environment variable 'BASED' should exists and setted to 'SVQ'\n" do
        let(:command) { `bundle exec ruby main.rb input.txt` }
      end
    end

    describe "with a not valid BASED value" do
      it_behaves_like "show error message",
                      error_message: "Error: Environment variable 'BASED' should exists and setted to 'SVQ'\n" do
        let(:command) { `BASED=PTOP bundle exec ruby main.rb input.txt` }
      end
    end

    describe "without filepath argument" do
      it_behaves_like "show error message",
                      error_message: "Error: First argument should exist and beeing an valid filepath\n" do
        let(:command) { `BASED=SVQ bundle exec ruby main.rb` }
      end
    end

    describe "without filepath argument" do
      it_behaves_like "show error message",
                      error_message: "Error: First argument should exist and beeing an valid filepath\n" do
        let(:command) { `BASED=SVQ bundle exec ruby main.rb non_existing_file.txt` }
      end
    end
  end
end
