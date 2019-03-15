require "simplecov"
SimpleCov.start

SimpleCov.start do
  add_filter %r{^/specs?/}
end
# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/hotel.rb"
require_relative "../lib/room.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/hotelblock.rb"
require_relative "../lib/csv_record.rb"
