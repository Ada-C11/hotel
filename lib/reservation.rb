# I can reserve a room for a given date range, so that I can make a
# reservation
# I can access the list of reservations for a specific date, so that
# I can track reservations by date
# I can get the total cost for a given reservation
# I want exception raised when an invalid date range is provided, so

# that I can't make a reservation for an invalid date range
# check if t <=> t2 is greater than or equal to 1
# or just check in date and number of nights, then autopopulate
# check out date
require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :name, :checkin_date, :num_of_nights
    attr_accessor :room_num, :cost, :number, :checkout_date

    def initialize(name, checkin_date, num_of_nights)
      @number = number #how do i get this to increment 1 each time?
      @name = name
      @checkin_date = Date.parse(checkin_date)
      @checkout_date = @checkin_date + num_of_nights
      if num_of_nights >= 1
        @num_of_nights = num_of_nights
      else
        raise ArgumentError, "Number of night must be greater than 0"
      end
      @room_num = nil
      @cost = num_of_nights * 200
      #@block = nil
    end
  end
end
