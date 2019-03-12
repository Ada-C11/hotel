module HotelSystem
  class Room
    attr_reader :number, :price
    attr_accessor :reservations

    def initialize(number:)
      @number = number
      @price = 200.00
      @reservations = []
    end

    def add_reservation
    end

    def update_status
    end
  end
end
