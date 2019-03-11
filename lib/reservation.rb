require "date"

class Reservation
  def initialize(check_in, check_out)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    if @check_out < @check_in
      raise ArgumentError, "Invalid dates, checkout date must be after checkin date."
    end
  end
end
