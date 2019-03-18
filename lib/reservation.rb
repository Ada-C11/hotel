require "date"
require "pry"

class Reservation
  attr_reader :start_date, :end_date, :room, :cost, :rooms, :block_name

  def initialize(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, room: "0", cost: 200, block_name: "no name")
    @start_date = start_date
    @end_date = end_date
    @room = room
    @cost = cost
    @block_name = block_name
  end

  def duration
    trip_duration = Date.parse(@end_date) - Date.parse(@start_date)
    if Date.parse(@start_date) < Date.today
      raise ArgumentError, "The start date cannot be in the past"
    elsif trip_duration < 1
      raise ArgumentError, "The duration must be at least one day"
    else
      return trip_duration
    end
  end

  def reservation_dates
    date_range = (Date.parse(@start_date)..Date.parse(@end_date)).to_a
    return date_range
  end

  def total_cost
    trip_cost = duration * @cost
    return trip_cost
  end
end
