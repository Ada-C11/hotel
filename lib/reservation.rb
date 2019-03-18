require "Date"

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room, :all_dates, :block_name, :booking_name, :discount

    def initialize(check_in:, check_out:, room:, block_name: nil, booking_name:, discount: nil)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      if @check_out < @check_in
        raise ArgumentError, "Check-out date cannot be before check-in date"
      end

      if @check_in == @check_out
        @all_dates = [@check_in]
      else
        @all_dates = (@check_in...@check_out).to_a
      end

      @room = room
      @block_name = block_name
      @booking_name = booking_name
      @discount = discount
    end

    def total_cost
      discount != nil ? discount.to_f : all_dates.length * room.rate
    end

    def change_booking_name(booking_name:)
      @booking_name = booking_name
    end
  end
end
