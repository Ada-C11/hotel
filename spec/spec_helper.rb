# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs/} #gives it a regular expression that filters out anything in the specs folder
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/hotel_manager.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_block.rb'
require_relative '../lib/date_range.rb'


