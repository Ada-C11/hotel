module HotelSystem
  class Room
    attr_reader :id, :reservations, :blocks
    attr_accessor :rate

    def initialize(id:, rate:)
      @id = id
      @rate = rate
      @reservations = {}
      @blocks = {}
    end

    def is_available?(new_date_range)
      reservations.each do |name, reservation|
        return false if reservation.overlap?(new_date_range)
      end
      return true
    end

    def is_blocked?(new_date_range)
      blocks.each do |group_name, block|
        return true if block.overlap?(new_date_range)
      end
      return false
    end

    def add_reservation(reservation)
      reservations[reservation.name] = reservation
    end

    def add_block(block)
      blocks[block.group_name] = block
    end

    def all_reservations
      return reservations.values
    end

    def all_blocks
      return blocks.values
    end
  end
end
