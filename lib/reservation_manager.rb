require_relative "reservation.rb"
require "date"

module Hotel
  class ReservationManager
    def initialize
      @reservations = []
    end

    def all_rooms
      rooms = (1..20).to_a
      return rooms
    end

    def make_reservation(room_number, check_in, check_out)
      new_reservation = Hotel::Reservation.new(room_number,
                                               check_in,
                                               check_out)

      @reservations << new_reservation

      return new_reservation
    end

    def reservations_by_date(date)
      reservations_by_date = []
      @reservations.each do |reservation|
        if date > reservation.check_in && date < reservation.check_out
          #Right now checkout day is not included because you can check-in on that day
          reservations_by_date << reservation
        end
      end
      return reservations_by_date
    end
  end
end
