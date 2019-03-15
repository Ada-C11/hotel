require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room, :price, :room_id

    def initialize(id:, room:, date_range:, price:)
      @id = id
      @room = room
      @room_id = room.id
      @date_range = date_range
      @price = price
    end

    def total_price
      price * date_range.duration
    end

    def overlap?(another_date_range)
      return date_range.overlap?(another_date_range)
    end
  end
end
