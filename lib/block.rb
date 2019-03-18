module Hotel
  class Block
    attr_reader :rooms, :start_date, :end_date, :discount_rate

    def initialize(rooms:, start_date:, end_date:, discount_rate:)
      @start_date = start_date
      @end_date = end_date
      validate_rooms(rooms)
      @rooms = rooms
      @rooms_and_status = create_hash_of_rooms_with_status(rooms)
      @discount_rate = discount_rate
    end

    def available_rooms?
      available_rooms = []
      @rooms_and_status.each do |room, status|
        available_rooms.push(room) if status == "AVAILABLE"
      end
      return available_rooms
    end

    def book_room(room)
      validate_room_for_booking(room)
      @rooms_and_status[room] = "UNAVAILBLE"
    end

    private

    def create_hash_of_rooms_with_status(rooms)
      hash = Hash[rooms.collect { |room| [room, "AVAILABLE"] }]
      return hash
    end

    def validate_rooms(rooms)
      unless rooms.length <= 5
        raise ArgumentError, "The max number of rooms for a block is 5."
      end
    end

    def validate_room_for_booking(room)
      unless rooms.include?(room)
        raise ArgumentError, "The selected room is not a part of this block."
      end
      unless available_rooms?.include?(room)
        raise ArgumentError, "This selected room has already been booked."
      end
    end
  end
end
