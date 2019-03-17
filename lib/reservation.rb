require_relative "room"
require_relative "date_range"
require_relative "block"

# need block id & connect block

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room, :price, :room_id, :block, :block_id

    def initialize(id:, room:, date_range:, price: 200, block: nil)
      @id = id
      @date_range = date_range
      raise ArgumentError, "Room already booked for this date" unless room.is_available?(date_range)
      @room = room
      @room_id = room.id
      @price = price
      @block = block

      if block
        @block_id = block.id
        connect(block)
      else
        @block_id = nil
      end

      connect(room)
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

    def connect(entity)
      entity.add_reservation(self)
    end
  end
end
