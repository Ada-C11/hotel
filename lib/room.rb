require_relative "reservation"

module Hotel
  class Room
    attr_reader :room_id, :cost, :reservations

    def initialize(room_id, cost: 200.0, reservations: nil)
      @room_id = room_id
      @cost = cost
      @reservations = reservations || []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def self.load_all
      @all_rooms = []
      20.times do |id|
        room = Room.new(id + 1, cost: 200.0, reservations: nil)
        @all_rooms << room
      end
      return @all_rooms
    end
  end
end
