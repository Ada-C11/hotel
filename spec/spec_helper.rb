require "SimpleCov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/hotel_ledger"
require_relative "../lib/room"
require_relative "../lib/reservation"
# require_relative "../lib/reservation_block"
require_relative "../lib/days"
