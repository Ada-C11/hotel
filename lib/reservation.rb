module Hotel
  class Reservation
    attr_reader :length_of_stay, :cost, :room, :nights

    def initialize(room:, nights:, block_id: nil, rate: room.rate)
      @length_of_stay = nights.length

      @nights = nights

      @room = room

      @cost = length_of_stay * rate

      @block_id = block_id
    end
  end
end
