class Reservation
  attr_reader :reservation_id, :check_in_day, :check_out_day, :room_number, :room_rate

  def initialize(room_number, reservation_id: 0, check_in_day: Date.today.to_s, check_out_day: (Date.today + 1).to_s, room_rate: 200)
    if room_number < 1 || room_number > 20
      raise ArgumentError, "Invaild room number. Room number must be between 1-20"
    else
      @room_number = room_number
    end
    @reservation_id = reservation_id
    @room_rate = room_rate
    if (Date.parse(check_out_day) - Date.parse(check_in_day)).to_i < 1
      raise ArgumentError, "Check out time cannot be before check in time"
    else
      @check_in_day = Date.parse(check_in_day)
      @check_out_day = Date.parse(check_out_day)
    end
  end

  def overlaps(check_in, check_out)
    return !(check_out <= @check_in_day || check_in >= @check_out_day)
  end

  # def contains(date)
  #   return date >= @check_in_day && date < @check_out_day
  # end

  def calculate_total_cost
    duration_of_stay = (@check_out_day - @check_in_day).to_i
    total_cost = @room_rate * duration_of_stay
    return total_cost
  end
end
