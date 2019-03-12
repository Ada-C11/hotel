require "csv"
require_relative "record"
require_relative "reservation"
require_relative "room"

module Hotel
  class RoomManager < Record
    attr_reader :rooms, :reservations

    def initialize
      @rooms = Room.load_all
      @reservations = Reservation.load_all
      connect_reservations
    end

    def self.reserve(room, check_in_date, check_out_date)
      reservation_id = @reservations.length + 1
      new_reservation = Reservation.new(
        reservation_id: reservation_id,
        room: room,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
    end

    # def get_list_reservations(check_in_date, check_out_date)
    #   current_reservations = self.reservations.map do |reservation|
    #     reservation.check_in_date >
    #   end
    # end

    def find_room(room_id)
      Room.validate_id(room_id)
    end

    def connect_reservations
      @reservations.each do |reservation|
        room = find_room(reservation.room_id)
        reservation.connect(room)
      end
    end
  end
end
