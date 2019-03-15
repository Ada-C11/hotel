module HotelSystem
  class Room
    attr_reader :room_number, :reservations, :block_nights


    def initialize(number)
      self.class.valid_room_number(number)
      @room_number = number
      @reservations = []
      @block_nights = []
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

    def add_block_nights(dates)
      if dates.class != HotelSystem::DateRange || dates.class != DateRange
        raise ArgumentError, "Please provide a date or DateRange."
      end
      if dates.class == HotelSystem::DateRange
        dates.date_list.each do |date|
          if date != dates.checkout
            block_nights << date
          end
        end
      else
        block_nights << dates
      end
    end

    def in_block?(year:, month:, day:)
      if year.digits.length != 4
        raise ArgumentError, "Please enter 4 digits for the year."
      elsif !Date.valid_date?(year, month, day)
        raise ArgumentError, "Please enter a valid date with 4 digits for the year and 1 or 2 digits for both the month and day."
      end
      given_date = Date.new(year, month, day)
      return block_nights.include?(given_date)
    end

  end
end
