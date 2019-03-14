module HotelSystem
  class HotelBlock
    attr_reader :date_range, :rooms, :room_rate

    def initialize(date_range:, rooms:, room_rate:)
      @date_range = date_range
      @rooms = rooms
      @room_rate = room_rate
    end
  end
end
