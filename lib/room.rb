# require_relative "reservation"

module Hotel
  class Room
    attr_reader :room_id, :cost, :reservations

    def initialize(room_id, cost: self.class.default_cost, reservations: nil)
      @room_id = room_id
      @cost = cost
      @reservations = reservations || []
    end

    def self.default_cost
      return 200.0
    end

    def self.num_rooms
      return 20
    end

    def self.load_all
      @all_rooms = []
      20.times do |id|
        room = self.new(id + 1, cost: 200.0, reservations: nil)
        @all_rooms << room
      end
      return @all_rooms
    end
  end
end
