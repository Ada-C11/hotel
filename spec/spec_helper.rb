# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/room.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/hotel_manager.rb"
require_relative "../lib/block.rb"
