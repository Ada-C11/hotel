module HotelSystem
  class Room
    attr_reader :id, :price, 

    def initalize(id:)
      @id = id
      @price = 200.00
      @reservations = []
    end

    def add_reservation
    end

    def update_status
    end
  end
end