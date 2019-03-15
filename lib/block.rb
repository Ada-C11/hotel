
module Hotel
  class Block
    attr_reader :rooms, :block_id, :range, :room_rate

    def initialize(range:, room_collection:, room_rate:, block_id:)
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
