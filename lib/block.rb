require_relative "room"
require_relative "date_range"
require_relative "reservation"

module Hotel
  class Block
    attr_reader :id, :date_range, :price, :rooms, :reservations

    def initialize(id:, date_range:, price:, rooms:)
      @id = id
      @date_range = date_range
      @price = price

      raise ArgumentError, "invalid number of rooms" if rooms.count < 2 || rooms.count > 5
      rooms.each do |room|
        if room.is_available?(date_range) == false || room.is_blocked?(date_range)
          raise ArgumentError, "Room Unavailable"
        end
      end

      @rooms = rooms
      @reservations = []

      connect_rooms
    end

    def overlap?(another_date_range)
      return date_range.overlap?(another_date_range)
    end

    def connect_rooms
      rooms.each do |room|
        room.add_block(self)
      end
    end

    def add_reservation(reservation)
      reservations.push(reservation)
    end

    def bookable_room
      room = rooms.find { |room| room.is_available?(date_range) }
      raise ArgumentError, "all rooms booked" unless room
      return room
    end
  end
end
