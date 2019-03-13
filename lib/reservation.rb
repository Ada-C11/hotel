require_relative "reservation_manager"

class Reservation
  attr_reader :reservation_id, :check_in_time, :check_out_time, :duration_of_stay, :total_cost, :all_rooms, :room_number

  COST_PER_NIGHT = 200

  def initialize(reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s)
    @room_number = all_rooms.sample
    @reservation_id = reservation_id
    @check_in_time = Date.parse(check_in_time)
    @check_out_time = Date.parse(check_out_time)
    @duration_of_stay
    @total_cost
    # binding.pry
  end

  def duration_of_stay
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

  def all_rooms
    @all_rooms = []
    20.times do |number|
      @all_rooms << number + 1
    end
    return @all_rooms
  end
end
