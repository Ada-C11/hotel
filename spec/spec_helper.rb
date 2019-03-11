require 'simplecov'
SimpleCov.start do 
  add_filter %r{^/specs?/}
end
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative 'Hotel'