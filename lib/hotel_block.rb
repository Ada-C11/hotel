require_relative "reservation"

module HotelSystem
  class HotelBlock
    attr_reader :id, :date_range, :rooms, :room_rate, :available_rooms

    def initialize(id:, date_range:, rooms:, room_rate:)
      @id = id
      @date_range = date_range
      @rooms = rooms
      @room_rate = room_rate
      @available_rooms = rooms
    end

    def room_available?(room)
      return available_rooms.include?(room)
    end

    def make_unavailable(room)
      @available_rooms.delete(room)
    end
  
  end
end
 