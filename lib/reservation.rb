require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :name, :checkin_date, :num_of_nights
    attr_accessor :room_num, :cost, :checkout_date, :reserved_nights, :block_reference

    def initialize(name, checkin_date, num_of_nights, block_reference: "CLASSIC")
      @name = name
      @checkin_date = Date.parse(checkin_date)

      if num_of_nights >= 1
        @num_of_nights = num_of_nights
      else
        raise ArgumentError, "Number of night must be greater than 0"
      end

      @checkout_date = @checkin_date + num_of_nights
      @reserved_nights = calculate_reserved_nights
      @room_num = nil
      @block_reference = block_reference
    end

    def calculate_reserved_nights
      reserved_nights = []
      counter = 0
      num_of_nights.times do
        reserved_night = @checkin_date + counter
        reserved_nights << reserved_night
        counter += 1
      end
      return reserved_nights
    end

    def cost
      if @block_reference == "CLASSIC"
        return @num_of_nights * 200
      else
        return @num_of_nights * 150
      end
    end
  end
end
