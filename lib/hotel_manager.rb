require_relative "room.rb"

module Hotel
  class Hotel_manager
    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    attr_reader :rooms

    def initialize
      @rooms = ROOM_NUMBERS.map do |number|
        Hotel::Room.new(room: number)
      end
      @reservations = []
    end
  end
end
