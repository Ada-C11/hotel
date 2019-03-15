require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'date'
require './lib/reservations'
require './lib/registry'
COST = 200
ROOMS = (1..20).to_a.freeze
