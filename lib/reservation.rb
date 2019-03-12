require "date"
require_relative "room"

module BookingSystem
  class Reservation
    attr_reader :room, :date_range, :cost

    def initialize(room:, checkin_date: nil, checkout_date: nil)
      @room = room
      unless checkin_date.instance_of?(Date) && checkout_date.instance_of?(Date) && checkout_date >= checkin_date
        raise ArgumentError.new("Check out date must be later than check in date, got check out: #{checkout_date} and check in: #{checkin_date}")
      end
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @date_range = (checkin_date...checkout_date)
    end

    def total_cost(date_range)
      # cost, num_of_nights = 0, 0
      # cost = (+1 num_of_nights for each in date_range) * STANDARD_RATE
      return cost # Or @cost?
    end
  end
end