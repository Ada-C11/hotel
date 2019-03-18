require "date"

module BookingSystem
  class Reservation
    attr_reader :room, :date_range, :cost

    def initialize(room:, checkin_date:, checkout_date:)
      @room = room
      unless checkin_date.instance_of?(Date) && checkout_date.instance_of?(Date) && checkout_date >= checkin_date
        raise ArgumentError.new("Please use instances of Date where checkout is later than checkin,
                                Got check out: #{checkout_date} and check in: #{checkin_date}")
      end
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      # Excludes checkout date for correct num of nights
      @date_range = (@checkin_date...@checkout_date)
    end

    def total_cost
      cost, num_of_nights = 0, 0
      num_of_nights = date_range.count
      return @cost = num_of_nights * room.price
    end
  end
end