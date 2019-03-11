module Hotel
  class ReservationManager
    def initialize
      @reservations = []
    end

    def reservations
      reservations << new_reservation # Where does reservation come from
    end

    def rooms
      rooms = (1..20).to_a
      return rooms
    end

    def create_reservation(start_date, end_date)
      room = rooms.sample
      new_reservation = Reservation.new(start_date, end_date, room)
      return new_reservation
    end
  end
end
