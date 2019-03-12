require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room, :room_id, :price, :hotel_block

    def initialize(id:, date_range:, room: nil,
                   room_id: nil, price: 200)
      @id = id
      @date_range = date_range
      @price = price
      @hotel_block = hotel_block

      if room
        @room = room
        @room_id = room.id
      elsif room_id
        @room_id = room
      else
        raise ArgumentError, "Room or room id is required"
      end
    end
  end
end
