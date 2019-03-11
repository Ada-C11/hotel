module Hotel
  class Room
    attr_reader :id, :cost, :reservations

    def initialize(id:, cost: 200, reservations: nil)
      @id = id
      @cost = cost
      @reservations ||= []
    end

    def add_reservation(reservation)
      reservations << reservation
    end
  end
end
