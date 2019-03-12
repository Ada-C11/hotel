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

    def list_reservations_by_date(date)
      reserved = []
      rooms.each do |room|
        room.unavailable.each do |reservation|
          if reservation.id[0] == "R" && reservation.check_in <= date && date < reservation.check_out
            reserved << room
          end
        end
      end
      return list_rooms(rooms_to_list: reserved)
    end
  end
end
