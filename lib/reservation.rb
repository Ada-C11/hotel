require "date"

module HotelModel
  class Reservation
    attr_reader :start_date, :end_date, :room_number, :rate, :total_cost

    def initialize(start_date:, end_date:, room_number:, rate: 200)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @room_number = room_number
      @rate = rate
      @total_cost = calculate_cost

      raise ArgumentError if @start_date >= @end_date
    end

    def calculate_cost
      nights = @end_date - @start_date
      total_cost = nights.to_i * @rate
      return total_cost
    end

    def conflicts_with?(reservation)
      return @room_number == reservation.room_number &&
             (@start_date >= reservation.start_date && @start_date < reservation.end_date) ||
             (@end_date >= reservation.start_date && @end_date <= reservation.end_date)
    end

    def overlaps_with?(start_range, end_range)
      return (start_range >= @start_date && start_range < @end_date) ||
             (end_range >= @start_date && end_range <= @end_date)
    end
  end
end
