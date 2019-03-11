require_relative "room"

module HotelSystem
  class Reservation
    attr_reader :room, :room_number

    def initialize(room: nil, room_number: nil)
      if room
        @room = valid_room(room)
        @room_number = room.room_number
      elsif room_number
        @room_number = valid_room_number(room_number)
      else
        raise ArgumentError, "Please enter either a Room or a room number."
      end
    end

    def valid_room(room)
      if room.class != room
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
