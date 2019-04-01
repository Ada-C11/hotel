require 'simplecov'
SimpleCov.start
require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module Hotel; end

# Require_relative your lib files here!
#require_relative '../lib/booking_manager.rb'
require_relative '../lib/reservations_child.rb'
require_relative '../lib/rooms_manager.rb'
require_relative '../lib/Reservations_Manager.rb'
