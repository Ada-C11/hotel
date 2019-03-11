module Hotel
  class Room
    attr_reader :cost_per_night

    def initialize(room_number, cost_per_night: 200)
      @room_number = room_number
      @cost_per_night = cost_per_night
    end
  end
end
