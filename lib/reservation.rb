require "pry"
require "date"

class Reservation
  ROOM_RATE = 200
  attr_accessor :name, :room_id, :start_date, :end_date, :total_cost

  def initialize(name:, room_id:, start_date:, end_date:)
    @name = name
    @room_id = room_id
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    if @start_date > @end_date
      raise ArgumentError, "The start_date should be before the end_date"
    end

    @total_cost = total_cost
  end

  def total_cost
    date_range = (@end_date - @start_date)
    total_cost = date_range.to_i * ROOM_RATE
    return total_cost
  end
end

# binding.pry
