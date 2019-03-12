module HotelSystem
  class Room
    attr_reader :id, :rate, :reservations

    def initialize(id:, rate:)
      @id = id
      @rate = rate
      @reservations = []
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def is_available?(new_date_range)
      reservations.each do |reservation|
        return false if get_date_range(reservation).overlap?(new_date_range)
      end
      return true
    end

    private

    def get_date_range(reservation)
      return reservation.date_range
    end
  end
end
