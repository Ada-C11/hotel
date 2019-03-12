require "date"

class Reservation
  attr_reader :name, :room_number, :check_in, :check_out
  ROOM_RATE = 200

  def initialize(name, room_number, check_in, check_out)
    @name = name
    @room_number = (1..20).to_a
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    if @check_out < @check_in
      raise ArgumentError, "Invalid dates, checkout date must be after checkin date."
    end
  end

  def reservation_cost
    (check_out - check_in) * ROOM_RATE
  end

  def all_rooms
    room_number
  end
end
