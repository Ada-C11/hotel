require "date"

class Reservation
  attr_reader :id, :room, :start_date, :end_date, :dates, :cost

  def initialize(id, room, start_date, end_date)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @room = room
    if @start_date > @end_date
      raise ArgumentError, "start_date must be before end_date"
    end
    @dates = date_range
    @cost = ((@dates.length) - 1) * 200
  end

  def date_range
    dates = []
    number_of_dates = (@end_date - @start_date).to_i
    i = 0
    number_of_dates.times do
      date = @start_date + i
      dates.push(date)
      i += 1
    end
    return dates
  end
end
