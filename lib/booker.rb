require "time"
require "date"

require_relative "room"
require_relative "reserve"
require_relative "date_range"

class RoomBooker
  attr_reader :check_in, :check_out, :list_all_rooms, :reservations, :rooms, :reservation_cost

  def initialize
    @rooms = hotel_rooms
    @reservations = []
  end

  def make_reservation(check_in:, check_out:)
    room = find_available_room
    reserved = Reservation.new(id: @reservations.length + 1, check_in: check_in, check_out: check_out, room_booked: room)
    room.booked_on((Date.parse(check_in)..Date.parse(check_out)))
    @reservations << reserved
  end

  def find_available_room
    @all_rooms.each do |room|
      if room.bookings.empty?
        return room
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

  def list_all_rooms # to see an easily readable list of all rooms
    @all_rooms.each do |room|
      puts "Room number: #{room.id}, price: #{room.price}"
    end
  end

  def search_completed_reservations(date)
    n_date = Date.parse(date)
    find_by_dates = []
    @reservations.each do |res_dates|
      if res_dates.dates_booked.include?(n_date)
        find_by_dates << res_dates
      end
    end

    if find_by_dates.empty?
      puts "No dates "
    else
      return find_by_dates
    end
  end

  def find_cost(id)
    @reservations.each do |res|
      if res.id == id
        return "#{res.total_cost}"
      end
    end
    return nil
  end
end
