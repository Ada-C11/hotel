
require_relative "room"
require_relative "reservation"
require_relative "hotelblock"

class Hotel
  attr_accessor :rooms, :reservations, :blocks

  def initialize
    @rooms = []
    @reservations = []
    @blocks = []

    20.times do |i|
      room = Room.new(i + 1, 200)
      rooms << room
    end
  end

  def list_rooms
    rooms.each do |room|
      return room.print_nicely
    end
  end

  def create_res_id
    return reservations.count + 1
  end

  def create_block_id
    return blocks.count + 1
  end

  def add_reservation(start_time, end_time)
    if (start_time <=> end_time) == 1
      raise ArgumentError, "End time must be later than start time"
    end

    room = find_available_rooms(start_time, end_time)[0]
    reservation = Reservation.new(create_res_id, start_time, end_time, room)
    room.add_reservation(reservation)
    reservations << reservation
  end

  def find_by_date(date)
    matching_reservations = []

    reservations.each do |res|
      if res.includes_date?(date)
        matching_reservations << res
      end
    end

    return matching_reservations
  end

  def find_available_rooms(start_time, end_time)
    available_rooms = []
    rooms.each do |room|
      if room.is_available?(start_time, end_time)
        available_rooms << room
      end
    end

    return available_rooms
  end
end
