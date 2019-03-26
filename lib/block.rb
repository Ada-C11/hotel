module Hotel
  class Block
    attr_reader :block_id, :room_ids, :reserved_dates, :discounted_rate
    MAX_NUM_ROOMS = 5
    private_constant :MAX_NUM_ROOMS

    def initialize(block_id, room_ids, reserved_dates, discounted_rate)
      if room_ids.length > MAX_NUM_ROOMS
        raise RoomNotAvailableError, "You cannot block out more than 5 rooms at once."
      end

      @block_id = block_id
      @room_ids = room_ids
      @reserved_dates = reserved_dates
      @discounted_rate = discounted_rate
    end
  end
end
