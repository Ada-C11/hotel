require_relative "../spec/spec_helper"

module Hotel
  class Manifest
    attr_reader :rooms
    NUMBER_OF_ROOMS = 20
    COST_OF_ROOM = 200
    Room = Struct.new(:id, :cost_per_day, :unavailable)

    def initialize
      @rooms = []
      NUMBER_OF_ROOMS.times do |i|
        id = i + 1
        rooms << Room.new(id, COST_OF_ROOM, [])
      end
    end

    def list_rooms
      list = ""
      rooms.each do |room, v|
        list += "Room number #{room.id} \n"
      end
      return list
    end

    def find_room(id)
      return rooms.find do |room|
               room.id == id
             end
    end
  end
end
