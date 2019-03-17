require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/booking_manager.rb'
require_relative '../lib/reservations_child.rb'
require_relative '../lib/rooms_manager.rb'
require_relative '../lib/Reservations_Manager'