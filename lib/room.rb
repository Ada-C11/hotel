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

    # Make collection
    def self.make_set(amount:, rate:)
      set = []
      (1..amount).each do |num|
        set << new(id: num, rate: rate)
      end
      return set
    end

    # Availability check methods:

    def is_reserved?(new_date_range)
      all_reservations.each do |reservation|
        return true if reservation.overlap?(new_date_range)
      end
      return false
    end

    def is_blocked?(new_date_range)
      blocks.each do |group_name, block|
        return true if block.overlap?(new_date_range)
      end
      return false
    end

    # 'Add' methods:

    def add_reservation(reservation)
      reservations[reservation.id] = reservation
    end

    def add_block(block)
      blocks[block.id] = block
    end

    # 'All' methods:

    def all_reservations
      return reservations.values
    end

    def all_blocks
      return blocks.values
    end

    # 'Find' methods

    def find_res_by_id(id)
      return reservations[id]
    end

    def find_block_by_id(id)
      return blocks[id]
    end
  end
end
