module Hotel
  class HotelBlock
    attr_reader :rooms, :date_range, :cost

    def initialize(rooms, date_range, cost = 100)
      if rooms.length > 5
        raise ArgumentError, "Blocks cannot be more than 5 rooms."
      end


      @rooms = rooms
      @date_range = date_range
      @cost = cost
      @reservations = []
    end

    def book_block_reservation(room, date_range)
      if rooms.length > 5
        raise ArgumentError, "You cannot book more than 5 rooms."
      end

      unless rooms_available.include?(room)
        raise ArgumentError, "Sorry, this room is not available for block reservations" 
      end
  
      reservation = Hotel::Reservation.new(room, date_range)
      @reservations << reservation
      return reservation
    end

    def rooms_available
      reserved_rooms = @reservations.map{|reservation| reservation.room}
      available_rooms = @rooms - reserved_rooms
      return available_rooms
    end

    def block_date_check(check_in, check_out)
      return check_in == @check_in && check_out == @check_out
    end

  end
end