
module Hotel
  class Block
    attr_reader :rooms

    def initialize(range:, room_collection:, room_rate:, block_id: rand(100...999))
      @range = range
      @rooms = room_collection
      @room_rate = room_rate
      @block_id = block_id
    end

    def available?
      rooms.length > 0
    end
  end
end
