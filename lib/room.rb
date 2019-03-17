
module Hotel
  class Room
    attr_reader :room_id, :cost
    COST = 200.0

    def initialize(room_id, cost: COST)
      @room_id = room_id
      @cost = cost
    end

    def self.num_rooms
      return 20
    end

    def self.load_all
      @all_rooms = []
      self.num_rooms.times do |id|
        room = self.new(id + 1, cost: COST)
        @all_rooms << room
      end
      return @all_rooms
    end
  end
end
