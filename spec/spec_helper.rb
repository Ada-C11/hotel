
require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "date"

require_relative "../lib/reservation.rb"
require_relative "../lib/custom_exceptions.rb"
require_relative "../lib/manifest.rb"
require_relative "../lib/booker.rb"
require_relative "../lib/unavailable.rb"
require_relative "../lib/room.rb"
require_relative "../lib/block.rb"
