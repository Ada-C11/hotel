require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room, :price, :room_id

    def initialize(id:, room:, date_range:, price: 200)
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

    def match_date(another_date_range)
      return (date_range.start_date == another_date_range.start_date) && (date_range.end_date == another_date_range.end_date)
    end
  end
end
