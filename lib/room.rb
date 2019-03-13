module HotelSystem
  class Room
    attr_reader :number, :price, :status
    attr_accessor :reservations

    def initialize(number)
      @number = number
      @price = 200.00
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def date_overlap?
    end
  end
end
