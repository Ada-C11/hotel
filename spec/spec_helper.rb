# Add simplecov
require "simplecov"
SimpleCov.start do
  add_filter %r{^/specs/}
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/reservation_manager.rb"
require_relative "../lib/reservation.rb"
