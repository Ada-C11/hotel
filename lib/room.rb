module Hotel
  class Room
    attr_reader :id, :cost
    def initialize(id, cost)
      @id = id
      @cost = cost
    end

    def self.list_rooms(starting_id, num_rooms, cost)
      rooms = []
      num_rooms.times do
        rooms << Room.new(starting_id, cost)
        starting_id += 1
      end
      @rooms = rooms
      return rooms
    end
  end
end