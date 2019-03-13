require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'date'
require_relative '../lib/datespans'
require_relative '../lib/reservations'
require_relative '../lib/registry'
require_relative '../lib/room_factory'
