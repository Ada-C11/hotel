require_relative "reservation"

module Hotel
  class Room
    attr_reader :id, :reservations, :blocks

    def initialize(id:, reservations: nil, blocks: nil)
      @id = id
      @reservations = reservations || []
      @blocks = blocks || []
    end

    def is_available?(date_range)
      reservations.each do |reservation|
        return false if reservation.overlap?(date_range)
      end
      return true
    end

    def add_reservation(reservation)
      reservations.push(reservation)
    end

    def is_blocked?(date_range)
      blocks.each do |block|
        return true if block.overlap?(date_range)
      end
      return false
    end

    def add_block(block)
      blocks.push(block)
    end
  end
end
