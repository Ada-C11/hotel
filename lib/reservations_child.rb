# reservations child
require 'date'
require 'rooms_manager'

module Hotel
  class Reservations
    attr_reader :room, :id, :price_per_night, :start_date, :end_date

    def initialize(room)
      @room = room[:room]
      @id = room[:id]
      @price_per_night = price_per_night
      @start_date = room[:start_date]
      @end_date = room[:end_date]
      raise ArgumentError, "End date can't be before start date" if booking_period < 0
    end
  

    def reservation_cost
      price_per_night = 200
      total_cost = booking_period * price_per_night 
      total_cost
    end

    def booking_period
      duration = @end_date - @start_date
      duration.to_i
    end
  end
end
