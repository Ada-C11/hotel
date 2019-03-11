require "time"
require_relative "room"
require_relative "reservation"

class Hotel
  attr_accessor :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []

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

  def add_reservation(start_time, end_time)
    if (start_time <=> end_time) == 1
      raise ArgumentError, "End time must be later than start time"
    end
    reservation = Reservation.new(create_res_id, start_time, end_time)

    reservations << reservation
  end
end
