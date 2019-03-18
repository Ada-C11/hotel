require "simplecov"
SimpleCov.start do
  add_filter %r{^/specs?/}
end
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/skip_dsl"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/reservation"
require_relative "../lib/reservation_manager"
require_relative "../lib/block"
require_relative "../lib/block_manager"
require_relative "../lib/reservations_blocks_template"
