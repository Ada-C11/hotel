module Hotel
  class Reservation

    attr_reader :room_number, :date_span

    def initialize(room_number, check_in, check_out)
      @room_number = room_number
      @cost_per_night = ROOM_COST
      @date_span = Hotel::DateSpan.new(check_in, check_out)
    end

    def total_cost
      total_cost = @cost_per_night * @date_span.stay_length
      return total_cost
    end
  end
end