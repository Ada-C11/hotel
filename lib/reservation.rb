require "date"
require "time"

module Hotel
  class Reservation
    attr_reader :booking_ref
    attr_accessor :booking_ref, :number_of_rooms, :first_room_number, :check_in, :check_out, :total_cost, :room_blocks

    RATE = 200.00
    DISCOUNTED_RATE = 160.00

    def initialize(booking_ref:, number_of_rooms:, first_room_number:, check_in:, check_out:)
      @booking_ref = booking_ref
      @number_of_rooms = check_block_size(number_of_rooms)
      @first_room_number = first_room_number
      @check_in = check_in
      @check_out = check_out
      @room_blocks = populate_room_blocks(first_room_number, number_of_rooms)
      @total_cost = total_cost_calc(number_of_rooms, check_out, check_in)
      if (first_room_number + (number_of_rooms - 1) > 20)
        raise ArgumentError, "Rooms exceed 20, change Room #{first_room_number}."
      end # if


      if (@check_in >= @check_out) || (@check_in < Date.today)
        raise ArgumentError, "Check-out date cannot be before check-in date. Check_out date cannot be earlier than today's date."
      end # if
    end

    def check_block_size(number_of_rooms)
      if (number_of_rooms <= 5)
        block_size = number_of_rooms
      else
        raise ArgumentError, "A block can only have 5 rooms or less."
      end 
      return block_size
    end


    def total_cost_calc(number_of_rooms, check_out, check_in)
      if (number_of_rooms == 1)
        total_cost = ((check_out - check_in) * number_of_rooms) * RATE
      else
        total_cost = ((check_out - check_in) * number_of_rooms) * DISCOUNTED_RATE
      end # if
      return total_cost
    end

    def populate_room_blocks(first_room_number, number_of_rooms)
      room_blocks = []
      for i in (0...number_of_rooms)
        room_blocks << (first_room_number + i)
      end
      return room_blocks
    end
  end
end
