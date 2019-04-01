require_relative "room"

module Hotel
  class Manifest
    attr_reader :rooms

    def initialize(rooms_aready_set_up: nil, rooms_to_set_up: [{ cost_per_night: 200, number_of_rooms: 20 }])
      @rooms = rooms_aready_set_up || []
      setup_rooms(rooms_to_set_up)
    end

    def setup_rooms(rooms_to_set_up)
      rooms_to_set_up.each do |group_rooms|
        group_rooms[:number_of_rooms].times do
          add_room_to_rooms(cost_per_night: group_rooms[:cost_per_night])
        end
      end
    end

    def add_room_to_rooms(cost_per_night:)
      rooms << RoomWrapper.room(cost: cost_per_night, room_number: rooms.length + 1)
    end

    def list_rooms(rooms_to_list: rooms)
      return rooms_to_list
    end

    def find_room(id:)
      return rooms.find do |room|
               room.id == id
             end
    end

    def find_unavailable_object(id:)
      rooms.each do |room|
        room.unavailable_list.each do |unavailable_object|
          return unavailable_object if unavailable_object.id == id
        end
      end
      return nil
    end

    def list_rooms_with_reservations_by_date(date:)
      return rooms.select do |room|
               room.reservation?(date: date)
             end
    end

    def list_available_rooms_by_date_range(date_range:)
      return rooms.select do |room|
               room.available_for_date_range?(date_range: date_range)
             end
    end
  end

  module RoomWrapper
    def self.room(cost:, room_number:)
      Room.new(cost_per_night: cost, id: room_number)
    end
  end
end
