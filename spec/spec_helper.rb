require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require "date"
require_relative '../lib/datespans.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/registry.rb'
