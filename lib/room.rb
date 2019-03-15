require_relative "reservation"

module Hotel
  class Room
    attr_reader :id, :reservations

    def initialize(id:, reservations: nil)
      @id = id
      @reservations = reservations || []
    end

    def is_available?(date_range)
      reservations.each do |reservation|
        return false if reservation.overlap?(date_range)
      end
      return true
    end

    def add_reservation(reservation)
      @reservations.push(reservation)
    end
  end
end
