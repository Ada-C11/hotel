
require_relative "reservations_blocks_template"

module Hotel
  class BlockManager < RandBTemplate
    attr_reader :blocks

    def initialize
      @blocks = []
      activity(@blocks)
    end

    def create_block(start_date, end_date, rooms, rate_discount)
      validate_date_range(start_date, end_date)

      if rooms.length > 5
        raise ArgumentError, "The block must have up to 5 rooms"
      else
        rooms_validated = []
        rooms.each do |room|
          rooms_validated << validate_room_availability(start_date, end_date, room)
        end
      end
      id = @blocks.length + 1
      new_block = Block.new(id, start_date, end_date, rooms, rate_discount)
      @blocks << new_block
      return new_block
    end

    def create_reservation_from_block(id, room)
      block = find_by_id(id)
      rooms_block = rooms_available_in_block(id)
      if rooms_block.include?(room)
        block.room.delete(room)
        reservation_manager = Hotel::ReservationManager.new
        reserva = reservation_manager.create_reservation(block.start_date, block.end_date, room)
      else
        raise ArgumentError, "The room does not exist within the block"
      end
    end

    def rooms_available_in_block(id)
      block = find_by_id(id)
      return block.room
    end
  end
end
