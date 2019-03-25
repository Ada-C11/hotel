require_relative "full_block"

module Hotel
  class Block
    attr_reader :name, :check_in, :check_out, :rooms, :rate

    def initialize(name, check_in, check_out, block, rate)
      check_number_of_rooms(block)
      @name = name
      @check_in = check_in
      @check_out = check_out
      @rooms = block
      @rate = rate
    end

    def check_number_of_rooms(block)
      if block.length > 5
        raise StandardError, "Maximum of 5 rooms per room block"
      end
    end

    def available
      available_rooms = rooms.find_all { |room| room.block_reserved == nil }

      if available_rooms.empty?
        raise NoRoomsAvailableInBlock, "No rooms currently available in this block"
      else
        return available_rooms
      end
    end

    def set_blocked_room_rate
      rooms.each do |room|
        room.cost = rate
      end
    end

    def reserve_room
      room = self.available.first
      room.block_reserved = true
      return room
    end
  end
end
