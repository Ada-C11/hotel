require "time"
require "date"

require_relative "room"
require_relative "reserve"
require_relative "date_range"

class RoomBooker < Date
  attr_reader :reservations, :rooms

  def initialize(rooms:)
    @rooms = rooms
    @reservations = []
  end

  def book_reservation(check_in:, check_out:)
    date_request = request_dates(check_in: check_in, check_out: check_out) # validate dates
    find_room = find_available_room(check_in: check_in, check_out: check_out) #find available room
    if find_room == nil
      raise ArgumentError, "No rooms are available for these dates"
    end
    # only make reservation if room is available
    reservation_request = make_reservation(id: (@reservations.length + 1), dates_booked: date_request, room_booked: find_room)

    find_room.booked_on(check_in: check_in, check_out: check_out)
    @reservations.push(reservation_request)
    return reservation_request
  end

  def make_reservation(id:, dates_booked:, room_booked:)
    reservation = Reservation.new(id: id, dates_booked: dates_booked, room_booked: room_booked)
    return reservation
  end

  def request_dates(check_in:, check_out:)
    date_range = DateRange.new(check_in: check_in, check_out: check_out).dates_booked
    return date_range
  end

  def find_room_id(id:)
    return rooms.find do |room|
             room.id == id
           end
  end

  def find_available_room(check_in:, check_out:)
    found_room = rooms.select do |room|
      room.room_available?(check_in: check_in, check_out: check_out)
    end
    return found_room[0]
  end

  def date_query(date:)
    find_dates = Date.parse(date)
    find_by_dates = reservations.select { |reserved| reserved.dates_booked.include?(find_dates) == true }
    return find_by_dates
  end

  def find_cost(id:)
    @reservations.each do |res|
      if res.id == id
        return "#{res.total_cost}"
      end
    end
    return nil
  end
end
