module HotelSystem
  class Room
    attr_reader :room_number, :reservations
    attr_accessor :price_per_night

    def initialize(number)
      self.class.valid_room_number(number)
      @room_number = number
      @price_per_night = 200
      @reservations = []
    end

    def self.valid_room_number(number)
      if number.class != Integer || number <= 0
        raise ArgumentError, "Please enter a whole number greater than 0."
      else
        return number
      end
    end

    def add_reservation(reservation)
      @reservations << reservation
    end
  end
end
