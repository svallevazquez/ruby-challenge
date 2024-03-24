# frozen_string_literal: true

shared_examples_for "not valid model" do |test_description:, error:|
  it test_description do
    expect(subject.valid?).to be_falsey
    expect(subject.errors).to include(error)
  end
end
