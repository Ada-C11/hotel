module Hotel
  class Reservation
    attr_reader :first_night, :last_night, :length_of_stay, :cost, :room, :nights

    def initialize(room:, nights:)
      @length_of_stay = nights.length

      @nights = nights

      @room = room

      @cost = length_of_stay * room.rate
    end
  end
end
