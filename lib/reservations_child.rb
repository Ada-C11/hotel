require 'date'
require 'booking_manager'
require 'rooms_manager'

module Hotel
  class Reservations < Booking
    attr_reader :room, :price_per_night

    def initialize(room)
      super(room)
      @room = room[:room]
      @price_per_night = 200
    end

    def reservation_cost
      total_cost = booking_period * @price_per_night
      return total_cost
    end
    
  end
end
