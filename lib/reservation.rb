require 'date'

class Reservation
  COST_PER_NIGHT = 200.00

  def initialize(time_interval)
    @time_interval = time_interval
  end
  # check there's a reservation on a specific date
  def includes_date?(date)
    date = Date.parse(date)
    return date >= @time_interval.check_in && date <= @time_interval.check_out
  end

  def get_total_cost
    duration = @time_interval.check_out - @time_interval.check_in
    return duration * COST_PER_NIGHT
  end
end