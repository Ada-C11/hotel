module Hotel
  class Room
    attr_reader :room_number, :reservations

    def initialize(room_number:, reservations: [])
      @room_number = room_number
      @reservations = []

      if room_number <= 0 || room_number > 20
        raise ArgumentError, "Room number must be between 1 & 20"
      end
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def is_available?(date_range)
      return !@reservations.any? { |res| res.date_range.overlap?(date_range) }
    end
  end
end
