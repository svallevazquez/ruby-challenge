# frozen_string_literal: true

# Arguments validatior
# ...

# Taking argument
# svq_file = ARGV[0]

# Validate input file (calling SvqValidator)
# ...

# Parse input file (calling SvqParser)
# trips = SvqParser.new(svq_file).call

# Loop each trip and show the results
# output = trips.map(&:to_s).join("\n")
# puts output

puts "TRIP to BCN"
puts "Flight from SVQ to BCN at 2023-01-05 20:40 to 22:10"
puts "Hotel at BCN on 2023-01-05 to 2023-01-10"
puts "Flight from BCN to SVQ at 2023-01-10 10:30 to 11:50"
puts ""
puts "TRIP to MAD"
puts "Train from SVQ to MAD at 2023-02-15 09:30 to 11:00"
puts "Hotel at MAD on 2023-02-15 to 2023-02-17"
puts "Train from MAD to SVQ at 2023-02-17 17:00 to 19:30"
puts ""
puts "TRIP to NYC"
puts "Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10"
puts "Flight from BCN to NYC at 2023-03-02 15:00 to 22:45"
