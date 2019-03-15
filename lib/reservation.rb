require_relative "reservation_manager"

class Reservation
  attr_reader :reservation_id, :check_in_time, :check_out_time, :total_cost, :all_rooms, :room_number

  COST_PER_NIGHT = 200

  def initialize(room_number, reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s, part_of_block: false)
    if room_number < 1 || room_number > 20
      raise ArgumentError, "Invaild room number. Room number must be between 1-20"
    else
      @room_number = room_number
    end
    @reservation_id = reservation_id
    if (Date.parse(check_out_time) - Date.parse(check_in_time)).to_i < 1
      raise ArgumentError, "Check out time cannot be before check in time"
    else
      @check_in_time = Date.parse(check_in_time)
      @check_out_time = Date.parse(check_out_time)
    end
    @part_of_block = part_of_block
  end

  def calculate_total_cost
    duration_of_stay = (@check_out_time - @check_in_time).to_i
    total_cost = COST_PER_NIGHT * duration_of_stay
    return total_cost
  end

  # private

  def all_rooms
    @all_rooms = []
    20.times do |number|
      @all_rooms << number + 1
    end
    return @all_rooms
  end
end
