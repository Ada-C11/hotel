require "date"

module Hotel
  class Reservation
    attr_reader :room_number, :check_in, :check_out
    ROOM_RATE = 200

    def initialize(room_number, check_in, check_out)
      @room_number = room_number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      if @check_out < @check_in
        raise ArgumentError, "Invalid dates, checkout date must be after checkin date."
      end
    end

    def reservation_cost
      (check_out - check_in) * ROOM_RATE
    end
  end
end
