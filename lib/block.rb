
module Hotel
  class Block
    def initialize(range:, room_collection:, room_rate:)
      @range = range
      @room_collection = room_collection
      @room_rate = room_rate
    end
  end
end
