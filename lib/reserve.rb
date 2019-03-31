require_relative "date_range"
require "awesome_print"

class Reservation < DateRange
  attr_reader :room_booked, :rate

  def initialize(room_booked, check_in, check_out, rate)
    @room_booked = room_booked
    @rate = rate
    super(check_in, check_out)
  end

  def total_cost
    return nights * @rate
  end
end
