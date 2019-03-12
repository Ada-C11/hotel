module HotelSystem
  class Room
    attr_reader :id, :reservations
    attr_accessor :rate, :block

    def initialize(id:, rate:, block: nil)
      @id = id
      @rate = rate
      @reservations = []
      @block = block
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

    private
  end
end
