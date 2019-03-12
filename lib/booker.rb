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
    
  end

  def make_reservation
    #Using the date range given it creates a reservation and books a room, appends an instance of Reserve to reservation array. 
    #What happens if no rooms are available?
  end

end

# check_in = DateTime.strptime(check_in, '%m-%d-%Y')
# check_out = DateTime.strptime(check_out, '%m-%d-%Y')