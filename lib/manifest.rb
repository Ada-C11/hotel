# require_relative "../spec/spec_helper"

module Hotel
  class Manifest
    attr_reader :rooms
    NUMBER_OF_ROOMS = 20
    COST_OF_ROOM = 200
    Room = Struct.new(:cost_per_day, :id)

    def initialize
      @rooms = {}
      NUMBER_OF_ROOMS.times do |i|
        id = i + 1
        rooms[Room.new(COST_OF_ROOM, id)] = { dates_booked: [] }
      end
    end

    def list_rooms
      list = ""
      rooms.each do |room, value|
        list += "Room number #{room.id} \n"
      end
      return list
    end
  end
end
