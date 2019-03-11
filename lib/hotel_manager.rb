require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Hotel_manager
    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    attr_reader :rooms, :reservations

    def initialize
      @rooms = ROOM_NUMBERS.map do |number|
        Hotel::Room.new(room: number)
      end
      @reservations = []
    end

    def make_reservation(room, start_date, end_date)
      new_reservation = Hotel::Reservation.new(room: room, start_date: start_date, end_date: end_date)
      @reservations.push(new_reservation)
      return new_reservation
    end

    def list_reservations_by_date(date)
      date = Date.parse(date)
      found_reservations = []
      @reservations.each do |reservation|
        if date >= reservation.start_date && date < reservation.end_date
          found_reservations.push(reservation)
        end
      end
      return found_reservations
    end
  end
end
