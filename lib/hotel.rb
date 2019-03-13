module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations, :hotel_blocks

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
      @hotel_blocks = []
    end

    def reserve_room(id, start_date, end_date, room_id)
      #check if room available during those days
      rooms_available = available_rooms(start_date, end_date)
      raise ArgumentError if !(rooms_available.include?(room_id))
      # find room object with room ID
      room = find_room(room_id)
      #
      return Reservation.new(id: id, start_date: start_date, end_date: end_date, room: room)
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
      avail_rooms = []
      @rooms.each do |room|
        if room.reservations == []
          avail_rooms << room
        else
          # could also use previous method #access_reservations here, loop through
          #reservations by date, and exclude rooms reserved on one of those dates

          check_avail = room.reservations.select do |reservation|
            !(reservation.start_date...reservation.end_date).include?(start_date) &&
            !(reservation.start_date..reservation.end_date).include?(end_date)
          end
          #   p "#{room.id}: #{check_avail}"
          avail_rooms << room if check_avail.length > 0
        end
      end
      return avail_rooms.map { |room| room.id } #return object?
    end

    def reserve_hotel_block(id, start_date, end_date, collection_rooms, discounted_rate)
      collection_rooms.each do |room|
        raise ArgumentError if !(available_rooms(start_date, end_date).include?(room.id))
      end
      return Block.new(id: id, start_date: start_date, end_date: end_date, collection_rooms: collection_rooms, discounted_rate: discounted_rate)
    end

    def add_hotel_block(block)
      hotel_blocks << block
    end

    def reserve_room_hotel_block
    end
  end
end
