module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations, :hotel_blocks

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
      @hotel_blocks = []
    end

    def reserve_room(start_date, end_date, room_id, block_id = nil, discount = nil)
      #check if room available during those days
      rooms_available = available_rooms(start_date, end_date)
      raise ArgumentError if !(rooms_available.include?(room_id)) && block_id == nil
      # find room object with room ID
      room = find_room(room_id)
      new_reservation = Reservation.new(id: create_reservation_id, start_date: start_date, end_date: end_date, room: room, block_id: block_id, discount: discount)
      add_reservation(new_reservation)
      room.add_reservation(new_reservation)

      return new_reservation
    end

    def create_reservation_id
      reservation_id = reservations.length + 1
      return reservation_id
    end

    def create_block_id
      block_id = hotel_blocks.length + 1
      return block_id
    end

    def find_room(room_ID)
      @rooms.detect { |room| room.id == room_ID }
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def access_reservations(date) # this is wrong
      list_reservations = @reservations.select { |reservation| (Range.new(reservation.start_date, reservation.end_date)).include?(date) }
      return list_reservations.map { |reservation| reservation }
    end

    def find_reservation(room_id, block_id)
      return reservations.detect { |reservation| reservation.room.id == room_id && reservation.block_id == block_id }
    end

    def available_rooms(start_date, end_date)
      avail_rooms = []
      rooms.each do |room|
        avail_rooms << room.id if room.isAvailable?(start_date, end_date)
      end
      return avail_rooms #return object instead?
    end

    def reserve_hotel_block(id, start_date, end_date, collection_rooms, discounted_rate)
      raise ArgumentError, "Max number of rooms is 5" if collection_rooms.length > 5
      collection_rooms.each do |room|
        raise ArgumentError, "Room not available" if !room.isAvailable?(start_date, end_date)
      end
      new_block = Block.new(id: id, start_date: start_date, end_date: end_date, collection_rooms: collection_rooms, discounted_rate: discounted_rate)
      collection_rooms.each do |room|
        room.add_block(new_block)
      end
      add_hotel_block(new_block)
      return new_block
    end

    def available_rooms_block(block_id)
      available_rooms = []
      block_select = find_block(block_id)
      block_select.collection_rooms.each do |room|
        if find_reservation(room.id, block_id).nil?
          available_rooms << room.id
        end
      end
      return available_rooms
    end

    def find_block(block_id)
      hotel_blocks.detect { |hotel_block| hotel_block.id == block_id }
    end

    def add_hotel_block(block)
      hotel_blocks << block
    end

    def reserve_room_hotel_block(room_id, block_id)
      if available_rooms_block(block_id).include?(room_id)
        block = find_block(block_id)
        reserve_room(block.start_date, block.end_date, room_id, block_id)
      else
        puts "can't reserve room in block"
      end
    end
  end
end
