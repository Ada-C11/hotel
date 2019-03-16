# require_relative "reservation"

module Hotel
  class Room
    attr_reader :room_id, :cost
    # , :reservations
    COST = 200.0

    def initialize(room_id, cost: COST, reservations: nil)
      @room_id = room_id
      @cost = cost
      # @reservations = reservations || []
    end

    def self.num_rooms
      return 20
    end

    def self.load_all
      @all_rooms = []
      self.num_rooms.times do |id|
        room = self.new(id + 1, cost: COST, reservations: nil)
        @all_rooms << room
      end
      return @all_rooms
    end
  end
end
