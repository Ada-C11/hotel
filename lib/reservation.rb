require 'date'

class Reservation

  attr_reader :first_name, :last_name :checkin_date, :checkout_date, :room_number

  def initialize(first_name, last_name, checkin_date, checkout_date)
    @first_name = first_name
    @last_name = last_name
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
  end

  def customer(first_name, last_name)
  
  end

  def check_date_range(start, finish)
    raise StandardError, 'Invalid date range' unless start < finish
  end





end

#   def find_room(room_number)
#   end
 # @last_night = checkout_date - 1
# @room = find_room(room_number)