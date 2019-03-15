
module Hotel
  class Block
    attr_reader :rooms, :id, :nights, :room_rate

    def initialize(nights:, room_collection:, room_rate:, id:)
      @nights = nights
      @rooms = room_collection
      @room_rate = room_rate
      @id = id
    end

    def has_available_rooms?
      rooms.length > 0
    end

    def book(room:)
      rooms.delete(room)
    end
  end
end
