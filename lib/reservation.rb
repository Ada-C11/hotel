class Reservation

  def initialize(time_interval, room_id)
    @time_interval = time_interval
    @room_id = room_id
  end
  # check there's a reservation on a specific date
  def includes_date?(date)
    return date >= time_interval.check_in && date <= time_interval.check_out
  end

end