module Hotel
  class ReservationManager
    attr_reader :reservations

    def initialize
      @reservations = []
    end

    def rooms
      @rooms = (1..20).to_a
      return @rooms
    end

    def create_reservation(start_date, end_date) # should I parse the dates here??? not when I'm creating the reservation in the specs??
      id = @reservations.length + 1
      room = rooms.sample
      new_reservation = Reservation.new(id, start_date, end_date, room)
      @reservations << new_reservation
      return new_reservation
    end

    def find_reservation_by_id(id:)
      index = 0
      if id.class == Integer
        @reservations.find do |reservation|
          if reservation.id == id
            return reservation
          end
        end
      end
    end

    def find_reservation_by_date(date: nil)
      if date.class == Time
        reservations_found = []
        @reservations.each_with_index do |reservation, index|
          if date >= reservation.start_date && date <= reservation.end_date
            reservations_found << reservation
          end
        end
        if reservations_found.empty?
          raise ArgumentError, "There are no reservations for that date"
        elsif reservations_found.length == 1
          return reservations_found[0] #RIGHT NOW RETURNING THE OBJECT WHEN THERE IS JUST ONE MATCH
        else
          return reservations_found
        end
      end
    end
  end
end
