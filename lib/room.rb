# Require gems

# Require relatives

module Hotel
  class Room
    attr_reader :room_number, :reservations

    def initialize(room_number:, reservations: nil)
      @room_number = room_number
      @reservations = reservations || []
    end
  end
end
