# frozen_string_literal: true

require "byebug"

begin
  # Taking argument
  svq_filepath = ARGV[0]

  # Arguments validation
  raise ArgumentError, "Environment variable 'BASED' should exists and setted to 'SVQ'" if ENV["BASED"] != "SVQ"
  if svq_filepath.nil? || !File.exist?(svq_filepath)
    raise ArgumentError, "First argument should exist and beeing an valid filepath"
  end

  # Parse input file (calling SvqParser)
  trips = RubyChallenge::SvqParser.new(svq_filepath:).call

  # Loop each trip and show the results
  output = trips.map(&:to_s).join("\n")
  puts output
rescue StandardError => e
  puts "Error: #{e.message}"
end
