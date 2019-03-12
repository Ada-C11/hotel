require_relative "room"
require_relative "reservation"

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20).map { |num| Hotel::Room.new(number: num) }
      @reservations = []
    end

    def request_reservation(check_in_date, check_out_date)
      reservation = Hotel::Reservation.new(check_in_date: check_in_date,
                                           check_out_date: check_out_date,
                                           room_number: rand(1..20))

      reservations << reservation
      find_room(reservation.room_number).add_reservation(reservation)
    end

    def find_room(room_number)
      rooms.find { |room| room.number == room_number }
    end

    def reservations_by_date(date)
      reservations.find_all { |reservation| reservation.all_dates.include?(Date.parse(date)) }
    end

    # def available_rooms(date)

    # end
  end
end
