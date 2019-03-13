require_relative "err/errors"

module HotelSystem
  class Block
    attr_reader :rooms, :date_range, :discount_rate, :reservations, :group_name, :id

    def initialize(rooms:, date_range:, discount_rate:, group_name:, id:)
      if rooms.length > 5 || rooms.length < 1
        raise BlockError, "A block must contain 1 to 5 rooms"
      end
      @rooms = rooms
      @id = id
      @discount_rate = discount_rate

      @rooms.each { |room| block_room(room) }
      @date_range = date_range
      @group_name = group_name

      @reservations = {}
    end

    def add_reservation(reservation)
      reservations[reservation.id] = reservation
    end

    def has_available_rooms?
      return rooms.any? { |room| !room.is_reserved?(date_range) }
    end

    def includes_date?(new_date_range)
      return date_range.includes_date?(new_date_range)
    end

    def overlap?(new_date_range)
      return date_range.overlap?(new_date_range)
    end

    def block_room(room)
      room.add_block(self)
    end

    def has_room?(room)
      return rooms.include?(room)
    end

    def all_reservations
      return reservations.values
    end
  end
end
