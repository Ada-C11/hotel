require 'simplecov'
SimpleCov.start do
  add_filter %r{^/specs?/}
end
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_dispatcher.rb'
require_relative '../lib/block.rb'
require_relative '../lib/date_range.rb'
