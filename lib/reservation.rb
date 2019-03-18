require "date"
require "time"

module Hotel
  class Reservation
    attr_reader :booking_ref
    attr_accessor :booking_ref, :number_of_rooms, :first_room_number, :check_in, :check_out, :total_cost, :room_blocks

    RATE = 200.00
    DISCOUNTED_RATE = 160.00

    def initialize(booking_ref:, number_of_rooms:, first_room_number:, check_in:, check_out:, total_cost:, room_blocks:)
      @booking_ref = booking_ref

      if (number_of_rooms <= 5)
        @number_of_rooms = number_of_rooms
      else
        raise ArgumentError, "A block can only have 5 rooms or less."
      end # if

      @first_room_number = first_room_number

      if (first_room_number + (number_of_rooms - 1) > 20)
        raise ArgumentError, "Rooms exceed 20, change Room #{first_room_number}."
      end # if

      @check_in = check_in
      @check_out = check_out

      if (@check_in >= @check_out) || (@check_in < Date.today)
        raise ArgumentError, "Check-out date cannot be before check-in date. Check_out date cannot be earlier than today's date."
      end # if

      if (number_of_rooms == 1)
        @total_cost = ((check_out - check_in) * number_of_rooms) * RATE
      else
        @total_cost = ((check_out - check_in) * number_of_rooms) * DISCOUNTED_RATE
      end # if

      @room_blocks = Array.new

      for i in (0...number_of_rooms)
        @room_blocks << (first_room_number + i)
      end
    end
  end
end
