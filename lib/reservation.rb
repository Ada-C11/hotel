require_relative "room"

module HotelSystem
  class Reservation
    attr_reader :room, :room_number, :id
    attr_accessor :dates

    def initialize(id:, room: nil, room_number: nil, dates: nil)
      if room != nil
        @room = valid_room(room)
        @room_number = room.room_number
      elsif room_number != nil
        @room_number = valid_room_number(room_number)
      else
        raise ArgumentError, "Please enter either a Room or a room number."
      end
      @dates = []
    end

    def valid_room(room)
      if room.class != Room
        raise ArgumentError, "Please enter a Room."
      else
        return room
      end
    end

    def valid_room_number(number)
      HotelSystem::Room.valid_room_number(number)
    end
  end
end
