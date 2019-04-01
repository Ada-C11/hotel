require_relative "room"
require_relative "hotel"

module HotelSystem
  class Reservation
    attr_reader :room_number, :id
    attr_accessor :date_range, :room, :nightly_rate

    def initialize(id:, room: nil, room_number: nil, date_range:, nightly_rate: 200)
      @id = id
      if room
        valid_room(room)
        @room = room
        @room_number = room.room_number
      elsif room_number
        valid_room_number(room_number)
        @room_number = room_number
      else
        raise ArgumentError, "Please enter either a Room or a room number."
      end
      @date_range = date_range
      @nightly_rate = nightly_rate
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

    def cost
      total = nightly_rate * date_range.num_nights
      return total
    end
  end
end
