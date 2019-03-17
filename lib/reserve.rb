require "date"
require_relative "room"
require "awesome_print"

class Reservation
  ROOM_RATE = 200.00

  attr_reader :id, :room_booked, :total_cost, :dates_booked

  def initialize(id: nil, room_booked: nil, dates_booked:)
    valid_id(id)

    @id = id
    @room_booked = room_booked
    @dates_booked = dates_booked
    @total_cost = total_cost
  end

  def total_cost
    total = (dates_booked.count-1) * ROOM_RATE
    return total
  end

  def valid_id(id)
    unless id.instance_of?(Integer)
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end
    return true
  end

end

