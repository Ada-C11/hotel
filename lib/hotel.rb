module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations, :hotel_blocks

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
      @hotel_blocks = []
    end

    def reserve_room(start_date, end_date, room_id)
      #check if room available during those days
      rooms_available = available_rooms(start_date, end_date)
      raise ArgumentError if !(rooms_available.include?(room_id))
      # find room object with room ID
      room = find_room(room_id)
      new_reservation = Reservation.new(id: create_reservation_id, start_date: start_date, end_date: end_date, room: room)
      add_reservation(new_reservation)
      room.add_reservation(new_reservation)

      return new_reservation
    end

    def create_reservation_id
      reservation_id = reservations.length + 1
      return reservation_id
    end

    def find_room(room_ID)
      @rooms.detect { |room| room.id == room_ID }
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def access_reservations(date)
      list_reservations = @reservations.select { |reservation| (Range.new(reservation.start_date, reservation.end_date)).include?(date) }
      return list_reservations.map { |reservation| reservation }
    end

    def available_rooms(start_date, end_date)
      # for reservation purposes, to check if that room can be reserved
      avail_rooms = []
      rooms.each do |room|
        avail_rooms << room if room.isAvailable?(start_date, end_date)
      end
      return avail_rooms.map { |room| room.id } #return object?
    end

    def reserve_hotel_block(id, start_date, end_date, collection_rooms, discounted_rate)
      collection_rooms.each do |room|
        raise ArgumentError if !room.isAvailable?(start_date, end_date)
      end
      return Block.new(id: id, start_date: start_date, end_date: end_date, collection_rooms: collection_rooms, discounted_rate: discounted_rate)
    end

    def available_rooms_block(start_date, end_date, block_id)
      available_rooms = []
      block = find_block(block_id)
      block.collection_rooms.each do |room|
        available_rooms << room if !available_rooms.include?(room.id)
      end
    end

    def add_hotel_block(block)
      hotel_blocks << block
    end

    def reserve_room_hotel_block
    end
  end
end
