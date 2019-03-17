require "date"

module Hotel
  class Reservation
    attr_reader :room_number, :check_in, :check_out, :block_id
    ROOM_RATE = 200

    def initialize(room_number, check_in, check_out, block_id: nil)
      @room_number = room_number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @block_id = block_id

      if @check_out < @check_in
        raise ArgumentError, "Invalid dates, checkout date must be after checkin date."
      end
    end

    def reservation_cost
      (check_out - check_in) * ROOM_RATE
    end

    def block_room_cost
      (check_out - check_in) * ROOM_RATE * 0.8
    end
  end
end
