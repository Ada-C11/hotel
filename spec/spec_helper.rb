require "simplecov"
SimpleCov.start do
  add_filter %r{^/specs?/}
end
# Add simplecov
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "date"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative "../lib/room.rb"
require_relative "../lib/reservation.rb"
require_relative "../lib/hotel.rb"
require_relative "../lib/block.rb"
require_relative "../lib/block_reservation.rb"

def create_block(num_rooms, first_day, last_day, discount)
  rooms = []
  num_rooms.times do |num|
    room = HotelSystem::Room.new(id: num)
    rooms << room
  end
  block = HotelSystem::Block.new(rooms: rooms, first_day: first_day, last_day: last_day, discount: discount)
  return block
end

def create_reservation(room, arrive_day, depart_day)
  reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
  return reservation
end

def create_block_reservation(room, arrive_day, depart_day)
  reservation = HotelSystem::BlockReservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
  return reservation
end

def create_room(id)
  return HotelSystem::Room.new(id: id)
end
