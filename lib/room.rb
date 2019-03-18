module Hotel
  class Room
    attr_reader :id, :cost
    attr_accessor :reservations
    def initialize(id, cost)
      @id = id
      @cost = cost
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def self.list_rooms(starting_id, num_rooms, cost)
      rooms = []
      num_rooms.times do
        rooms << Room.new(starting_id, cost)
        starting_id += 1
      end
      return rooms
    end
  end
end