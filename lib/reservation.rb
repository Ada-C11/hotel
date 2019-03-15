require "Date"

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room, :all_dates, :block_name, :booking_name, :discount

    def initialize(check_in:, check_out:, room:, block_name: nil, booking_name:, discount: nil)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      if @check_in == @check_out
        @all_dates = [@check_in]
      else
        @all_dates = (@check_in...@check_out).to_a
        # map { |date| date }
      end

      @room = room
      @block_name = block_name
      @booking_name = booking_name
      @discount = discount

      if check_out < check_in
        raise ArgumentError, "Check-out date cannot be before check-in date"
      end
    end

    def total_cost
      discount != nil ? discount : all_dates.length * room.rate
    end
  end
end
