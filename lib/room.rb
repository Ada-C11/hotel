module Hotel
  class Room
    def initialize(room_number, cost_per_night: $200)
      @room_number = room_number
      @cost_per_night = cost_per_night
    end
  end
end
