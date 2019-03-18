require_relative "reservation_manager"

module Hotel
  class BlockManager #< ReservationManager
    attr_reader :blocks

    def initialize
      @blocks = []
      # activity(@blocks)
    end

    # def activity(activity)
    #   @activity = activity
    #   puts @activity
    # end

    def rooms
      @rooms = (1..20).to_a
      return @rooms
    end

    def create_block(start_date, end_date, rooms, rate_discount)
      validate_date_range(start_date, end_date)

      if rooms.length > 5
        raise ArgumentError, "The block must have up to 5 rooms"
      else
        rooms_validated = []
        rooms.each do |room|
          # THIS IS -> CHECK BLOCKS WHEN CREATING NEW BLOCK
          rooms_validated << validate_room_availability(start_date, end_date, room)
          # puts "#{rooms_validated}"
        end
      end
      id = @blocks.length + 1
      new_block = Block.new(id, start_date, end_date, rooms, rate_discount)
      @blocks << new_block
      return new_block
    end

    def create_reservation_from_block(id, room) #(id, start_date, end_date, room, rate_discount)
      block = find_block_by_id(id)
      rooms_block = rooms_available_in_block(id)
      if rooms_block.include?(room)
        block.rooms.delete(room)
        reservation_manager = Hotel::ReservationManager.new # THIS IS CREATING A NEW @reservations array... not what i want
        reserva = reservation_manager.create_reservation(block.start_date, block.end_date, room)
        # reserva = create_reservation(block.start_date, block.end_date, room)
        # puts "#{reserva.room_number}"
        # return reserva
      else
        raise ArgumentError, "The room does not exist within the block"
      end
    end

    # def find_reservations_by_block(id)
    #   block = find_block_by_id(id)
    #   reservation_manager = Hotel::ReservationManager.new ## IT CREATES A NEW @reservations
    #   reserva = reservation_manager.find_reservation_by_date(block.start_date, block.end_date)
    #   return reserva
    # end

    def validate_date_range(start_date, end_date)
      if start_date > end_date
        raise ArgumentError, "Invalid date range"
      else
        @start_date = start_date
        @end_date = end_date
      end
    end

    def rooms_available_in_block(id)
      block = find_block_by_id(id)
      return block.rooms
    end

    def find_block_by_id(id)
      index = 0
      if id.class == Integer
        @blocks.find do |reservation|
          if reservation.id == id
            return reservation
          end
        end
        raise ArgumentError, "Invalid reservation id"
      end
    end

    def validate_room_availability(start_date, end_date, room_selected)
      begin
        rooms_available = find_available_rooms(start_date, end_date)
        # puts "HERE #{rooms_available}"
      rescue ArgumentError
        if rooms.include?(room_selected)
          # puts "#{room_selected}"
          room = room_selected
          return room
        else
          # puts "Executing validate room availability"
          raise ArgumentError, "The room number is not valid"
        end
      else
        if rooms_available.include?(room_selected)
          room = room_selected
          return room
        else
          raise ArgumentError, "The room number is not available"
        end
      end
    end

    def find_available_rooms(start_date, end_date) # modified different from ReservationManager find available rooms
      blocks = find_reservation_by_date(start_date, end_date)

      rooms_in_blocks = []
      blocks.each do |block|
        rooms_in_blocks << block.rooms #array
      end

      return available_rooms(rooms_in_blocks)
    end

    def available_rooms(rooms_in_blocks)
      available_rooms = rooms
      rooms_in_blocks.each do |rooms_block|
        available_rooms -= rooms_block
      end
      return available_rooms
    end

    def find_reservation_by_date(start_date_find, end_date_find)
      if start_date_find.class == Time && end_date_find.class == Time
        reservations_found = []
        # puts "HERE"
        @blocks.each do |block|
          # puts "$$$$$$$#{block.start_date}"
          unless block.start_date >= end_date_find || block.end_date <= start_date_find
            reservations_found << block
            # puts "OOVER HERE#{reservations_found}"
          end
        end

        if reservations_found.empty?
          raise ArgumentError, "There are no reservations for that date"
        else
          return reservations_found
        end
      end
    end
  end
end
