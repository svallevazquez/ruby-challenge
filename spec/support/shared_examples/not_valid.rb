# frozen_string_literal: true

shared_examples_for "not valid" do |not_valid_message|
  it not_valid_message do
    expect(subject.valid?).to be_falsey
  end
end