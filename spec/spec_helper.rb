require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/reservation_booker"
require_relative "../lib/reservation"
require_relative "../lib/room"
require_relative "../lib/all_rooms"
require_relative "../lib/date_range"
# Require_relative your lib files here!
