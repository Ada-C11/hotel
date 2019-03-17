require 'date'
require 'pry'

module Hotel
  class Booking
    # Reservations will create a reservation and stimate prices
    attr_reader :id, :start_date, :end_date

    def initialize(room)
      @id = room[:id]
      @start_date = room[:start_date]
      @end_date = room[:end_date]
      raise ArgumentError.new ("End date can't be before start date") if booking_period < 0
    end

    def booking_period
      duration = @end_date - @start_date
      return duration.to_i
    end
  end
end
