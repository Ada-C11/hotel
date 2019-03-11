module Hotel
  class Room
    attr_reader :id, :cost, :reservations

    def initialize(id:, cost: 200, reservations: nil)
      @id = id
      @cost = cost
      @reservations ||= []
    end
  end
end
