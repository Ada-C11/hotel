class Reservation
  attr_reader :room_id, :total_cost

  def initialize(time_interval, room_id, room_rate)
    @reserved_dates = time_interval
    @room_id = room_id
    @total_cost = (@reserved_dates.check_out - @reserved_dates.check_in) * room_rate
  end

  def overlap?(time_interval)
    return @reserved_dates.overlap?(time_interval)
  end

  def has_date?(date)
    return @reserved_dates.has_date?(date)
  end
end