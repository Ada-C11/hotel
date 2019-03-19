require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

require_relative "../lib/room_reservation"
require_relative "../lib/reservation.rb"
require_relative "../lib/block.rb"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
