require_relative "reservation_manager"

class Reservation
  attr_reader :reservation_id, :check_in_time, :check_out_time, :room_number, :room_rate

  def initialize(room_number, reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s, room_rate: 200)
    if room_number < 1 || room_number > 20
      raise ArgumentError, "Invaild room number. Room number must be between 1-20"
    else
      @room_number = room_number
    end
    @reservation_id = reservation_id
    @room_rate = room_rate
    if (Date.parse(check_out_time) - Date.parse(check_in_time)).to_i < 1
      raise ArgumentError, "Check out time cannot be before check in time"
    else
      @check_in_time = Date.parse(check_in_time)
      @check_out_time = Date.parse(check_out_time)
    end
  end

  def calculate_total_cost
    duration_of_stay = (@check_out_time - @check_in_time).to_i
    total_cost = @room_rate * duration_of_stay
    return total_cost
  end
end
