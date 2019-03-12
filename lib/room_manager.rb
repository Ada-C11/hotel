require "csv"

module Hotel
  class RoomManager
    attr_reader :id

    def initialize
      @id = id
      create_rooms
    end

    def list_rooms
      @all_rooms
    end

    private

    def create_rooms
      @all_rooms = []
      20.times do |id|
        room = {
          "id" => id + 1,
          "status" => :AVAILABLE,
          "cost" => 200,
        }
        @all_rooms << room
      end
      return @all_rooms
    end
  end
end
