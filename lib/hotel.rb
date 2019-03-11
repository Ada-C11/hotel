module Hotel
  class Hotel
    attr_reader :id, :rooms, :reservations

    def initialize(id:, rooms:, reservations: nil)
      @id = id
      @rooms = rooms
      @reservations ||= reservations
    end

    def reserve_room(id, start_date, end_date, room_id)
      # find room object with room ID
      room = find_room(room_id)
      return Reservation.new(id: id, start_date: start_date, end_date: end_date, room: room)
    end

    def find_room(room_ID)
      @rooms.detect { |room| room.id == room_ID }
    end

    def add_reservation(reservation)
      reservations << reservation
    end
  end
end
