STANDARD_RATE = 200

module BookingSystem
  class Room
    attr_reader :room_num, :price
    attr_accessor :reservations

    def initialize(room_num:, price: STANDARD_RATE, reservations: [])
      @room_num = room_num
      @price = price
      @reservations = reservations
    end

    def self.instantiate_rooms(start_room_num, num_of_rooms)
      i = start_room_num
      while i <= num_of_rooms
        room = BookingSystem::Room.new(room_num: i)
        i += 1
      end
      rooms << room
      return rooms
    end

    def add_reservation(reservation)
      reservations << reservation
    end
  end
end