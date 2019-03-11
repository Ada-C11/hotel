module HotelSystem
  class Room
    attr_reader :room_number
    attr_accessor :price_per_night

    def initialize(number)
      @room_number = self.class.valid_room_number(number)
      @price_per_night = 200
    end

    def self.valid_room_number(number)
      if number.class != Integer || number <= 0
        raise ArgumentError, "Please enter a whole number greater than 0."
      else
        return number
      end
    end
  end
end
