module HotelSystem
  class Room
    attr_reader :id, :reservations, :blocks
    attr_accessor :rate

    def initialize(id:, rate:)
      @id = id
      @rate = rate
      @reservations = []
      @blocks = []
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def is_available?(new_date_range)
      reservations.each do |reservation|
        return false if reservation.overlap?(new_date_range)
      end
      return true
    end

    def is_blocked?(new_date_range)
      blocks.each do |block|
        return true if block.overlap?(new_date_range)
      end
      return false
    end

    private
  end
end
