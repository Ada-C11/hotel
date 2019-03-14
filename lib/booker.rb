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
    room = find_available_room
    reserved = Reservation.new(id: @reservations.length + 1, check_in: check_in, check_out: check_out, room_booked: room)

    @reservations << reserved
  end

  def find_available_room
    @all_rooms.each do |room|
      if room.bookings.empty?
        return room
      end
      # find by date
    end
  end

  def hotel_rooms
    @all_rooms = []
    20.times do |room_num|
      @all_rooms << Room.new(@id = room_num + 1)
    end
    return @all_rooms
  end

  def list_all_rooms
    @all_rooms.each do |room|
      puts "Room number: #{room.id}, price: #{room.price}"
    end
  end

  def search_bookings(date)
   find_by_dates = @reservations.map do |res_dates|
    if (res_dates.check_in..res_dates.check_out).include?(date)
      res_dates
    end
   end
  
    if find_by_dates.empty?
      puts "No dates "
    else
      return find_by_dates
    end
  end
end
