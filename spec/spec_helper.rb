require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/block_room.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/front_desk.rb"
