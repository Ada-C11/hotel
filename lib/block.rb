require_relative "err/errors"

module HotelSystem
  class Block
    attr_reader :rooms, :date_range, :discount_rate, :reservations

    def initialize(rooms:, date_range:, discount_rate:)
      @rooms = rooms
      @date_range = date_range
      @discount_rate = discount_rate
      @rooms.each { |room| block_room(room) }
      @reservations = []
    end

    def overlap?(new_date_range)
      return date_range.overlap?(new_date_range)
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def block_room(room)
      room.blocks << self
      room.rate = discount_rate
    end
  end
end
