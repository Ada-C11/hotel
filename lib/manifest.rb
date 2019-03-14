require_relative "room"

module Hotel
  class Manifest
    attr_reader :rooms
    NUMBER_OF_ROOMS = 20
    COST_OF_ROOM = 200.0

    def initialize(rooms: nil)
      @rooms ||= []
      NUMBER_OF_ROOMS.times { add_room_to_rooms }
    end

    def add_room_to_rooms(cost_per_night: COST_OF_ROOM)
      rooms << RoomWrapper::room(cost: cost_per_night, room_number: rooms.length + 1)
    end

    def list_rooms(rooms_to_list: rooms)
      raise ArgumentError.new("Must pass param as Array") if rooms_to_list.class != Array
      list = ""
      rooms_to_list.length.times do |i|
        list += "Room number #{rooms_to_list[i].id}\n"
      end
      return list
    end

    def find_room(id)
      return rooms.find do |room|
               room.id == id
             end
    end

    def list_unavailable_rooms_by_date(date)
      return rooms.reject do |room|
               room.room_available?(date: date)
             end
    end

    def next_available_room(check_in:, check_out:)
    end
  end

  module RoomWrapper
    def self.room(cost:, room_number:)
      Room.new(cost_per_night: cost, id: room_number)
    end
  end
end
