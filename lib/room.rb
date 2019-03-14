require "date"
require_relative "date_range"

class Room < DateRange
  ROOM_RATE = 200.00
  attr_reader :id, :price, :bookings, :booked_on

  def initialize(id)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end

    @id = id
    @price = ROOM_RATE
    @bookings = []
  end

  def booked_on(reservation)
    @bookings << reservation #will have an array of it's own bookings
  end
end
