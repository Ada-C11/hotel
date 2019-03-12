require "time"
require "date"

require_relative "room"

class Reservation
  attr_accessor :id, :room, :start_time, :end_time, :total_price

  def initialize(id, start_time, end_time, room)
    @start_time = start_time
    @end_time = end_time
    @room = room
    @id = id
    @total_price = find_total_price
  end

  def find_total_price
    number_of_days = end_time - start_time
    return room.price * number_of_days
  end

  def includes_date?(date)
    return start_time <= date && end_time >= date ? true : false
  end
end
