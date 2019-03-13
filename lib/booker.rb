require "csv"
require "chronic"
require "time"
require "date"

require_relative "room"
require_relative "reserve"
require_relative "date_range"

class RoomBooker < DateRange
  attr_reader :check_in, :check_out, :list_all_rooms, :list_reservations, :rooms

  def initialize
    @rooms = hotel_rooms
    @reservations = []
  end

  def make_reservation(check_in, check_out)
    room = find_room_id
    @reserved = Reservation.new(id: @reservations.length + 1, check_in: check_in, check_out: check_out, room_booked: room)

    add_reservation(@reserved)
  end

  def find_available_room
    @all_rooms.each do |room|
      if room.bookings.empty?
        return room.id
      end
    end
  end

  def hotel_rooms
    @all_rooms = []
    20.times do |room_num|
      @all_rooms << Room.new(@id = room_num + 1)
    end
    return @all_rooms
  end

  def add_reservation(res)
    @reservations << res
  end

  def list_all_rooms
    @all_rooms.each do |room|
      puts "Room number: #{room.id}, price: #{room.price}"
    end
  end

  def list_reservations
    @reservations
  end
end
