# I can access the list of reservations for a specific date, so that
# I can track reservations by date

# check if t <=> t2 is greater than or equal to 1

require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :name, :checkin_date, :num_of_nights
    attr_accessor :room_num, :cost, :checkout_date, :reserved_nights #, :number

    def initialize(name, checkin_date, num_of_nights)
      #@number = number #how do i get this to increment 1 each time?
      @name = name
      @checkin_date = Date.parse(checkin_date)
      @checkout_date = @checkin_date + num_of_nights
      if num_of_nights >= 1
        @num_of_nights = num_of_nights
      else
        raise ArgumentError, "Number of night must be greater than 0"
      end
      @reserved_nights = []
      counter = 0
      num_of_nights.times do
        reserved_night = @checkin_date + counter
        @reserved_nights << reserved_night
        counter += 1
      end
      @room_num = nil
      @cost = num_of_nights * 200
      #@block = nil
    end
  end

  # def connect(reservation, room)
  # @passenger = passenger
  # passenger.add_trip(self)
  # @driver = driver
  # driver.add_trip(self)
  #   end

end
