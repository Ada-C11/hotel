require "date"
require_relative "room"

class Reservation
  ROOM_RATE = 200.00

  attr_reader :id, :check_in, :check_out, :room_booked, :total_cost, :dates_booked

  def initialize(id: nil, check_in: nil, check_out: nil, room_booked: nil, total_cost: nil)
    valid_date?(check_in)
    valid_date?(check_out)
    date_range_valid?(check_in, check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @id = id
    @room_booked = room_booked # get from room available
    @total_cost = count_nights(check_in, check_out) * ROOM_RATE
    @dates_booked = dates_booked
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
    return (@check_in...@check_out)
  end

  def date_range_valid?(check_in, check_out)
    if check_out < check_in
      raise ArgumentError, "Check out date cannot occur before check in date"
    end
    return true
  end

  def valid_date?(date_str)
    begin
      date = Date.parse(date_str)
    rescue ArgumentError
      puts "Invalid date given, #{date_str}"
    end

    if Date.today > date
      raise ArgumentError, "Date cannot occur before current date, given: #{date_str}"
    end
  end
end
