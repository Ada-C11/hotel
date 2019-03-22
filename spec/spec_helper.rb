require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "simplecov"
SimpleCov.start

require_relative "../lib/hotel"
require_relative "../lib/reservation"
require_relative "../lib/block"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
