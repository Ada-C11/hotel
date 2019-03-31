
class DateRange
  class InvalidDateError < StandardError; end

  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)
    unless check_in < check_out
      raise InvalidDateError, "Invalid date order: #{check_in} to #{check_out}"
    end

    @check_in = check_in
    @check_out = check_out
  end

  def overlaps(other)
    return !(other.check_out <= @check_in || other.check_in >= @check_out)
  end

  def contains(date)
    return date >= @check_in && date < @check_out
  end

  def nights
    return @check_out - @check_in
  end
end
