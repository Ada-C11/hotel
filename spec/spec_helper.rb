require "SimpleCov"
require "pry"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

require "date"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/hotel_ledger"
require_relative "../lib/reservation_block"
