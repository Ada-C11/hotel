class Reservation
  attr_reader :reservation_id, :check_in_time, :check_out_time, :duration_of_stay

  def initialize(reservation_id: 0, check_in_time: nil, check_out_time: nil)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
  end

  def duration_of_stay
    #check out time - check in time = some time in days
    unless @check_in_time == nil && @check_out_time == nil
      @check_in_time = Date.parse(check_in_time)
      @check_out_time = Date.parse(check_out_time)
    end

    return (check_out_time - check_in_time).to_i
  end

  def total_cost
  end
end
