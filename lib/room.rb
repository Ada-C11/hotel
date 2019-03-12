module Hotel
  class Room
    attr_reader :id, :cost, :status

    def initialize(id, cost: 200, status: nil)
      @id = id
      @cost = cost
      @status = status
    end
  end
end
