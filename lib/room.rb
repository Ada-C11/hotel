module HotelSystem
  class Room
    attr_reader :room_number, :reservations, :block_date_ranges

    def initialize(number)
      self.class.valid_room_number(number)
      @room_number = number
      @reservations = []
      @block_date_ranges = []
    end

    def self.valid_room_number(number)
      if number.class != Integer || number <= 0
        raise ArgumentError, "Please enter a whole number greater than 0."
      else
        return number
      end
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def add_block_date_ranges(dates)
      if dates.class != HotelSystem::DateRange && dates.class != Date
        raise ArgumentError, "Please provide a date or DateRange. You've provided a #{dates.class}."
      end
      block_date_ranges << dates
    end

    def in_block?(year:, month:, day:)
      if year.digits.length != 4
        raise ArgumentError, "Please enter 4 digits for the year."
      elsif !Date.valid_date?(year, month, day)
        raise ArgumentError, "Please enter a valid date with 4 digits for the year and 1 or 2 digits for both the month and day."
      end
      given_date = Date.new(year, month, day)
      self.block_date_ranges.each do |range|
        if range.include?(given_date)
          return true
        end
      end
      return false
    end
  end
end
