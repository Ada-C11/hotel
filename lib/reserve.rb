require "date"
require_relative "date_range"
require_relative "room"

class Reservation < DateRange
  attr_reader :id, :check_in, :check_out, :room_booked, :total_cost, :dates_booked

  def initialize(id: nil, check_in: nil, check_out: nil, room_booked: nil, total_cost: nil)
    valid_date?(check_in)
    valid_date?(check_out)
    date_range_valid?(check_in, check_out)
    
    @check_in = check_in
    @check_out = check_out
    @id = id
    @room_booked = room_booked # get from room available
    @total_cost = count_nights(check_in, check_out) * 200.00
    dates_booked
  end

  def count_nights(check_in, check_out)
    start = Date.parse(check_in)
    leave = Date.parse(check_out)
    nights = (start...leave).count
    return nights
  end

  def valid_id(id)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end
  end

  def dates_booked
    return (@check_in...@check_out) #work in progres...
  end

  def valid_date?(date)
    super
  end

  def date_range_valid?(check_in, check_out)
    super
  end

  private
end
