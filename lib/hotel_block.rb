require 'date'

module Hotel
  class Block < Date_Range

    attr_reader :requested_rooms, :discounted_rate, :available_rooms, :reserved_rooms
    
    def initialize(requested_rooms, checkin_date, checkout_date, discounted_rate)
      @requested_rooms = requested_rooms
      @available_rooms = requested_rooms.dup
      @reserved_rooms = []
      @discounted_rate = discounted_rate
      super(checkin_date, checkout_date)
    end

    # checks that rooms are available
    def available?
      if @available_rooms.length > 0
        return true
      end
    end

    def reserve_room
      unless available?
        raise ArgumentError, "There are no available rooms."
      end
      
      reserved_room = @available_rooms.pop
      @reserved_rooms << reserved_room
    
      return reserved_room
    end

  end # END OF CLASS
end # END OF MODULE


