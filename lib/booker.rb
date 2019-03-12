require "csv"
require "chronic"
require 'time'
require 'date'

require_relative "room"
require_relative "reserve"


module Hotel
  class Booking
    attr_reader :check_in, :check_out, :number_of_rooms
    
    def initialize(check_in: nil, check_out: nil, number_of_rooms: nil)
      check_in = Chronic.parse(check_in)
      check_out = Chronic.parse(check_out)
   
      @check_in = check_in
      @check_out = check_out
      @number_of_rooms = number_of_rooms
    end

    def verify_date(date) #verify that date entered is a real date
      unless Date.valid_date?(date)
        raise ArgumentError, "Invalid date, given #{date}"
      end
    end

    def make_reservation do
      #Using the date range given it creates a reservation and books rooms and creates an instance of Reserve. 
      #This method will eventually have to find available rooms.
      #What happens if no rooms are available?
    end

  end
end

# check_in = DateTime.strptime(check_in, '%m-%d-%Y')
# check_out = DateTime.strptime(check_out, '%m-%d-%Y')