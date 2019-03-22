require "date"

class Reservation
  attr_reader :start_date, :end_date, :room_number, :rate

  def initialize(start_date:, end_date:, room_number:, rate: 200)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @room_number = room_number
    @rate = rate
  end

  def calculate_cost
    nights = (@end_date - @start_date)
    total_cost = nights * @rate
    return total_cost
  end
end
