
class DateRange
  attr_reader :check_in, :check_out

  def initialize(check_in: nil, check_out: nil)
    valid_date?(check_in)
    valid_date?(check_out)
    date_range_valid?(check_in: check_in, check_out: check_out)

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)

    @dates_booked = dates_booked
  end

  def date_range_valid?(check_in:, check_out:)
    if check_out < check_in || check_in == nil || check_out == nil
      raise ArgumentError, "Check out date cannot occur before check in date and dates cannot be nil"
    end
    return true
  end

  # def include_date_range?(date_range)
  #   check_in <= date_range.check_in && check_out >= date_range.check_out
  # end

  # def overlap_date_range?(date_range)
  #   start_date <= date_range.end_date && end_date >= date_range.start_date
  # end

  def valid_date?(date_str)
    format = "%Y-%m-%d"
    begin
      date = Date.parse(date_str, format)
    rescue ArgumentError
      puts "Invalid date given, #{date_str}"
    end

    if Date.today > date
      raise ArgumentError, "Date cannot occur before current date, given: #{date_str}"
    end
    return true
  end

  def dates_booked
    return (@check_in..@check_out)
  end
end
