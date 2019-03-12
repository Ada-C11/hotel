require "date"
require "pry"

class Reservation
  attr_reader :reservation_id, :start_date, :end_date, :rooms, :reservation_dates, :duration, :total_cost, :reservation_durations_array

  def initialize(reservation_id: 0, start_date: Date.today, end_date: Date.today + 1)
    @reservation_id = reservation_id
    @start_date = start_date
    @end_date = end_date
  end

  def duration
    # add something to make sure date is not in past

    duration = Date.parse(@end_date) - Date.parse(@start_date)
    if duration < 1
      raise ArgumentError, "The duration must be at least one day"
    else
      return duration
    end
  end

  def reservation_dates
    date_range = Date.parse(@start_date)..Date.parse(@end_date)
    return date_range
  end

  def total_cost
    cost = duration * 200
    return cost
  end

  def assign_room
    @rooms = ("1".."20").to_a
    return @rooms.sample
  end
end
