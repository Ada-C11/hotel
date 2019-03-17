module Hotel
  class Scheduler
    def initialize(num_rooms)
      @rooms = Hash.new
      @blocks = Hash.new
      num_rooms.times do |i|
        @rooms[i] = Room.new(i)
      end
      @next_block_id = 0
    end

    def get_room_ids
      return @rooms.keys.sort
    end

    def reserve_room(room_id, date_range)
      @rooms[room_id].reserve(date_range)
    end

    def get_reservations(date)
      list = Array.new
      @rooms.each_key { |id|
        r = @rooms[id].get_reservation_on_date(date)
        if !r.nil?
          list << r
        end
      }
      return list
    end

    def get_available_rooms(date_range)
      list = Array.new
      @rooms.each_key { |id|
        if @rooms[id].is_available?(date_range)
          list << @rooms[id].room_id
        end
      }
      return list
    end

    def create_block(date_range, room_ids, discounted_rate)
      room_ids.each do |id|
        if !@rooms[id].is_available?(date_range)
          raise ArgumentError, "One of the rooms in your block is not available."
        end
      end

      block = Block.new(@next_block_id, room_ids, date_range, discounted_rate)
      @blocks[block.block_id] = block
      @next_block_id = @next_block_id + 1
      
      return block.block_id
    end
  end
end