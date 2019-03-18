require "date"

class Block < Reservation
  attr_reader :id, :rooms, :cost, :room_rate, :dates

  def initialize(id, rooms, start_date, end_date)
    super
    @rooms = rooms
    # @rooms.each do |room|
    #   room.reservations.each do |reservation|
    #     raise ArgumentError, "can't make this block, room is not available for that date range"
    #   end
    # end
    @room_rate = room_rate
    @cost = ((@dates.length) - 1) * (@room_rate.to_i)
    @dates = date_range
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
