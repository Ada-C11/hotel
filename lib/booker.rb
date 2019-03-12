require "csv"
require "chronic"
require 'time'
require 'date'

require_relative "room"
require_relative "reserve"
require_relative 'date_range'

class Booking
  attr_reader :check_in, :check_out
  
  def initialize(check_in: nil, check_out: nil)
    # check_in = Chronic.parse(check_in)
    # check_out = Chronic.parse(check_out)
    check_in = valid_date?(check_in)
    check_out = valid_date?(check_out)
    date_range_valid?(check_in, check_out)

    @check_in = check_in
    @check_out = check_out
  end

  def valid_date?(date_str)
    format = "%Y-%m-%d"
    date_str = Date.strptime(date_str,format).to_s
    begin
      Date.parse(date_str)
    rescue ArgumentError => exception
      puts "Invalid date given #{date_str} need: YYYY-MM-DD"
    end
  end

  def date_range_valid?(check_in, check_out) 
    unless check_in < check_out
      raise ArgumentError, "Check out date cannot occur before check in date"
    end
  end

  def make_reservation
    #Using the date range given it creates a reservation and books a room, appends an instance of Reserve to reservation array. 
    #What happens if no rooms are available?
  end

end

# check_in = DateTime.strptime(check_in, '%m-%d-%Y')
# check_out = DateTime.strptime(check_out, '%m-%d-%Y')