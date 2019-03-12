# Add simplecov
require "simplecov"
SimpleCov.start

require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "date"

# Require_relative your lib files here!
require_relative "../lib/reservation.rb"
require_relative "../lib/custom_exceptions.rb"
require_relative "../lib/manifest.rb"
require_relative "../lib/booker.rb"
