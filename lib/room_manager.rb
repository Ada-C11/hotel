require_relative "reservation"
require_relative "room"

module Hotel
  class RoomManager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Room.load_all
      @reservations = Reservation.load_all
      connect_reservations
    end

    def reserve(room, check_in_date, check_out_date)
      reservation_id = @reservations.length + 1
      new_reservation = Reservation.new(
        reservation_id: reservation_id,
        room: room,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
      @reservations << new_reservation
    end

    def list_reservations(date)
      date = Date.parse(date)
      reservations = self.reservations.select do |reservation|
        date >= reservation.check_in_date && date < reservation.check_out_date
      end
      return reservations
    end

    def find_room(room_id)
      Room.validate_room_id(room_id)
      return @rooms.find { |room| room.room_id == room_id }
    end

    private

    def connect_reservations
      @reservations.each do |reservation|
        room = find_room(reservation.room_id)
        # reservation.connect(room)
      end
    end
  end
end
