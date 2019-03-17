
class DateRange
  attr_reader :check_in, :check_out

  def initialize(check_in: nil, check_out: nil)
    unless valid_date?(check_in) && valid_date?(check_out)
      raise ArgumentError, "Check out date cannot occur before check in date and dates cannot be nil"
    end

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    unless @check_in < @check_out
      raise ArgumentError, "Invalid date order"
    end

    @dates_booked = dates_booked
  end

  def valid_date?(date_str)
    date = Date.parse(date_str)

    if Date.today > date
      raise ArgumentError, "Date cannot occur before current date, given: #{date_str}"
    end
    return true
  end

  def dates_booked
    return (@check_in..@check_out)
  end
end
