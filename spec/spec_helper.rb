require 'simplecov'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/datespans.rb'
require_relative '../lib/reservations.rb'
require_relative '../lib/availability.rb'
require_relative '../lib/booking_manager.rb'

