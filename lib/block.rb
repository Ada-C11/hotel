require_relative "err/errors"

module HotelSystem
  class Block
    attr_reader :rooms, :date_range, :discount_rate, :reservations, :id

    def initialize(rooms:, date_range:, discount_rate:, id:)
      if rooms.length > 5 || rooms.length < 1
        raise BlockError, "A block must contain 1 to 5 rooms"
      end

      @id = id
      @discount_rate = discount_rate
      @rooms = rooms
      @reservations = {}
      @date_range = date_range
      @rooms.each { |room| block_room(room) }
    end

    # Room interaction methods

    def block_room(room)
      room.add_block(self)
    end

    def has_available_rooms?
      return rooms.any? { |room| !room.is_reserved?(date_range) }
    end

    def has_room?(room)
      return rooms.include?(room)
    end

    # Reservation interaction methods

    def all_reservations
      return reservations.values
    end

    def add_reservation(reservation)
      reservations[reservation.id] = reservation
    end

    def find_res_by_id(id)
      return reservations[id]
    end

    # Date interaction methods

    def includes_date?(new_date)
      return date_range.includes_date?(new_date)
    end

    def overlap?(new_date_range)
      return date_range.overlap?(new_date_range)
    end
  end
end
