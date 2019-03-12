class Reservation
  attr_reader :reservation_id, :check_in_time, :check_out_time, :duration_of_stay, :total_cost

  COST_PER_NIGHT = 200

  def initialize(reservation_id: 0, check_in_time: nil, check_out_time: nil)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    # @room_number = (1..20).to_a.sample
    # @all_rooms = (1..20).to_a
  end

  def duration_of_stay
    if @check_in_time != nil && @check_out_time != nil
      @check_in_time = Date.parse(check_in_time)
      @check_out_time = Date.parse(check_out_time)
    else
      return nil
    end

    duration = (check_out_time - check_in_time).to_i

    if duration <= 0
      raise ArgumentError, "Check out time cannot be before or during check in time"
    else
      return duration
    end
  end

  def total_cost
    COST_PER_NIGHT * (duration_of_stay - 1)
  end

end
