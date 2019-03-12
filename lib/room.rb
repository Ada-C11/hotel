module HotelSystem
  class Room
    attr_reader :id, :rate, :reservations

    def initialize(id:, rate:, reservations: nil)
      @id = id
      @rate = rate
      @reservations = reservations || []
    end

    def add_reservation(reservation)
      reservations << reservation
    end
  end
end
