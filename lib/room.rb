module HotelSystem
  class Room
    attr_reader :room_number, :reservations
    attr_writer :in_block

    def initialize(number)
      self.class.valid_room_number(number)
      @room_number = number
      @reservations = []
      @in_block = false
    end

    def in_block?
      return @in_block
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
