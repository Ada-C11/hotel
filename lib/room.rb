require_relative "reservation"

module Hotel
  class Room
    attr_reader :id, :reservations

    def initialize(id:, reservations: nil)
      @id = id
      @reservations = reservations || []
    end

    def room_available?(date)
      @reservations.each do |reservation|
        return false if reservation.date_range.overlap?(date)
      end
      return true
    end
  end
end
