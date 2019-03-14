require "date"

class Reservation
  attr_reader :id, :room_id, :start_date, :end_date, :dates, :cost

  def initialize(id, room, start_date, end_date)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @room_id = room_id
    if @start_date > @end_date
      raise ArgumentError, "start_date must be before end_date"
    end
    @dates = []
    date_range = (@end_date - @start_date).to_i
    i = 0
    date_range.times do
      date = @start_date + i
      @dates.push(date)
      i += 1
    end
    @cost = ((date_range.to_i) - 1) * 200
  end
end
