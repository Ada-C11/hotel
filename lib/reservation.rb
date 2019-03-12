require_relative "date_range"

module HotelSystem
  class Reservation
    attr_reader :date_range, :room

    def initialize(date_range:, room:, id:)
      @id = id
      @room = room
      @date_range = date_range
    end

    def total_cost
      return rate * number_of_nights
    end

    private

    def rate
      return room.rate
    end

    def number_of_nights
      return date_range.dates.length
    end
  end
end
