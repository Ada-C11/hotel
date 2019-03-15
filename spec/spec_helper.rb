require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'date'
require 'pry'
# require_relative '../lib/datespans'
require  './lib/reservations.rb'
require './lib/registry.rb'
# require_relative '../lib/room_factory'
