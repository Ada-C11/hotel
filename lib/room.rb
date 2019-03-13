# Require gems

# Require relatives

module Hotel
  class Room
    attr_reader :room_number, :reservations, :cost_per_night

    def initialize(room_number:, reservations: nil, cost_per_night: 200.00)
      @room_number = room_number
      @reservations = reservations || []
      @cost_per_night = cost_per_night
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def is_available?(date_range)
      #availability = true

      @reservations.each do |reservation|
        reservation_range = (reservation.check_in..reservation.check_out)
        if !(date_range.end <= reservation_range.begin || date_range.begin >= reservation_range.end)
          return false
        end
      end
      return true
    end
  end
end
