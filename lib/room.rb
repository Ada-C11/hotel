
module HotelSystem
  class Room
    attr_reader :id, :reservations, :price_per_night

    def initialize(id:, price_per_night: 200, reservations: [])
      @id = id
      @price_per_night = price_per_night
      @reservations = reservations
    end

    def add_reservation(reservation)
      @reservations << reservation
    end
  end
end
