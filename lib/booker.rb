require "time"
require "date"

require_relative "room"
require_relative "reserve"
require_relative "date_range"
require_relative "blocks"

class RoomBooker < Date
  attr_reader :reservations, :rooms, :get_available_rooms

  def initialize(rooms:)
    @rooms = rooms
    @reservations = []
    @blocked_reservations = []
  end

  def book_reservation(check_in:, check_out:)
    date_request = DateRange.new(check_in: check_in, check_out: check_out)
    res_dates = date_request.dates_booked
    find_room = find_available_room(check_in: check_in, check_out: check_out)
    if find_room == nil
      raise ArgumentError, "No rooms are available for these dates"
    end
    reservation_request = make_reservation(id: (@reservations.length + 1), dates_booked: res_dates, room_booked: find_room)

    find_room.booked_on(check_in: check_in, check_out: check_out)
    @reservations.push(reservation_request)
    return reservation_request
  end

  def make_reservation(id:, dates_booked:, room_booked:)
    reservation = Reservation.new(id: id, dates_booked: dates_booked, room_booked: room_booked)
    return reservation
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

  def get_available_rooms(check_in:, check_out:)
    open_rooms = []
    @rooms.each do |room|
      room.room_available?(check_in: check_in, check_out: check_out) ? open_rooms << room : next
    end
    if open_rooms.length == 0
      raise ArgumentError, "No rooms are available for the provided date range."
    end
    return open_rooms
  end

  # working on blocked rooms

  def reserve_block(check_in:, check_out:, rooms_needed:, discount_price:)
    raise ArgumentError if rooms_needed > 5
    block_rooms = []

    rooms_needed.times do |i|
      room = find_available_room(check_in: check_in, check_out: check_out)
      block_rooms << room
    end

    if reserved_block.length < rooms_needed
      raise ArgumentError, "We cannot book this block reservation due to insufficient room availability"
    end

    block = BlockParty.new(id:)
  end
end
