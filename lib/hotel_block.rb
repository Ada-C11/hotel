module Hotel
  class HotelBlock
    attr_reader :room, :check_in, :check_out, :cost, :reservations, :hotel

    def initialize(room, check_in, check_out, cost = 200)
      if room.length > 5
        raise ArgumentError, "Blocks cannot be more than 5 rooms."
      end
      
      @hotel ||= hotel
      @room = room
      @check_in = check_in
      @check_out = check_out
      @cost = cost
      @reservations = []
    end

    # def add_reservation(room, check_in, check_out, cost)

    #   if dates_match(check_in, check_out) == false
    #     raise ArgumentError, "The date range provided does not match this block."
    #   end
      
    #   unless rooms_available.include?(room)
    #     raise ArgumentError, "There are no available rooms."
    #   end
    
    #   reservation = Hotel::Reservation.new(room, check_in, check_out)
    #   # shovel into room reservations array
    #   @reservations << reservation
    #   return reservation
    # end

    # # check to see if check in and check out match instances of check in and check out
    # def dates_match(check_in, check_out)
    #   return check_in == @check_in && check_out == @check_out
    # end

    # # map over reservations array to find available rooms by room number
    # def rooms_available
    #   reserved_rooms = @reservations.map{|reservation| reservation.room_number}
    #   available_rooms = @room - reserved_rooms
    #   return available_rooms
    # end

    # def make_block(room, check_in, check_out, rate = 100)
    #   hotel_block = Hotel::HotelBlock.new(room, check_in, check_out, rate)
    #   @reservations << hotel_block
    #   return hotel_block
    # end

    # def search_block_date(check_in, check_out)
    #   return @reservations.find do
    #     |block| block.dates_match(check_in, check_out)
    #   end
    # end

    # def book_block(room, check_in, check_out)
    #   reservation = Hotel::Reservation.new(room, check_in, check_out, cost: 200)
    #   return reservation
    # end

  end
end