require "date"

module Hotel
  class Reservation
    attr_reader :checkin_date, :num_of_nights
    attr_accessor :name, :room_num, :checkout_date, :reserved_nights, :block_reference, :block_availability

    REG_PRICE = 200
    BLOCK_PRICE = 150

    def initialize(name, checkin_date, num_of_nights, block_reference: "N/A", block_availability: :UNAVAILABLE)
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
      @block_availability = block_availability
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
      return @block_reference == "N/A" ? @num_of_nights * REG_PRICE : @num_of_nights * BLOCK_PRICE
    end
  end
end
