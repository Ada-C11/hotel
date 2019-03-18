require "time"
require "date"

require_relative "reservation.rb"
require_relative "room.rb"
require_relative "block.rb"
require_relative "helpers.rb"

module Hotel
  class Reservation_Manager
    attr_accessor :rooms, :reservations, :blocks

    ROOM_IDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    ROOM_COST = 200.0

    def initialize
      @rooms = upload_rooms
      @blocks = []
    end

    # pushes constant variables into array, linking with room id
    def upload_rooms
      rooms = []
      ROOM_IDS.each do |id|
        room = Room.new(id)
        rooms << room
      end

      return rooms
    end

    # Wave 1 requirement - User can access list of all rooms in hotel
    def see_rooms
      return @rooms
    end
  end
end
