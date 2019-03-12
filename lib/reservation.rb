require "date"
require "pry"

class Reservation
  attr_reader :reservation_id, :start_date, :end_date, :rooms, :reservation_dates
  # removed from attr_reader: :duration, :total_cost, :reservation_durations_array

  def initialize(reservation_id: 0, start_date: nil, end_date: nil)
    @reservation_id = reservation_id
    @start_date = start_date
    @end_date = end_date
    @rooms = ("1".."20").to_a
    @reservation_dates_array = []
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
    date_range = (Date.parse(@start_date)..Date.parse(@end_date)).to_a
    if @start_date != nil && @end_date != nil
      @reservation_dates_array << date_range
      # binding.pry
    end
    return @reservation_dates_array
  end

  def total_cost
    cost = duration * 200
    return cost
  end

  def assign_room
    room = @rooms.sample
    return room
  end
end
