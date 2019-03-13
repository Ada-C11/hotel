require_relative "reservation"

module Hotel
  class Room
    attr_reader :room_id, :cost, :reservations

    def initialize(room_id, cost: 200.0, reservations: nil)
      self.class.validate_room_id(room_id)
      @room_id = room_id
      @cost = cost
      @reservations = reservations || []
    end

    def self.validate_room_id(room_id)
      if room_id.nil? || room_id <= 0 || room_id > 20
        raise ArgumentError, "ID cannot be blank, less than zero or larger than 20."
      end
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
