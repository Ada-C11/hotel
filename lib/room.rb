require "date"

class Room
  ROOM_RATE = 200.00
  attr_reader :id, :price, :bookings, :booked_on

  def initialize(id)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end

    @id = id
    @bookings = []
  end

  def booked_on(reservation_span)
    @bookings << reservation_span #will have a range of it's own bookings
  end
end
