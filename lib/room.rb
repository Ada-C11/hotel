module Hotel
  class Room
    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    attr_reader :room_number, :cost_per_night

    def initialize(room_number, cost_per_night: 200)
      @room_number = room_number
      @cost_per_night = cost_per_night
    end

    def self.make_rooms(numbers)
      rooms = numbers.map do |number|
        Hotel::Room.new(number)
      end
      return rooms
    end

    def self.make_rooms_standard
      self.make_rooms(ROOM_NUMBERS)
    end
  end
end
