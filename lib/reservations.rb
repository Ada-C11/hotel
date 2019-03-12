module Hotel
  class Reservation

    attr_reader :room_number, :date_range

    def initialize(room_number, cost_per_night, date_range)
      @room_number = room_number
      @cost_per_night = ROOM_COST
      @date_range = Hotel::DateRange.new(check_in, check_out)
    end

    def total_cost
      total_cost = @cost_per_night * @date_range.stay_length
      return total_cost
    end

  end
end