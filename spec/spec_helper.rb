require 'simplecov'
SimpleCov.start do
 add_filter %r{^/specs/}
end

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation_manager.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_block.rb'
