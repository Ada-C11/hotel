module HotelSystem
  class Room
    def initialize(id:, rate:, reservations: nil)
      @id = id
      @rate = rate
      @reservations = reservations || []
    end
  end
end
