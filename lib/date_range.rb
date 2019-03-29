require 'date'

module Hotel
  class Date_Range
    attr_reader :checkin_date, :checkout_date

    def initialize(checkin_date, checkout_date)
      unless checkout_date > checkin_date
        raise ArgumentError, "These dates are invalid."
      end

      @checkin_date = checkin_date
      @checkout_date = checkout_date
    end

    def overlaps(new_date_range)
      if (new_date_range.checkout_date <= @checkin_date) || (new_date_range.checkin_date >= @checkout_date)
        return false
      else
        return true
      end
    end

    def contains(date)
      if date >= @checkin_date && date < @checkout_date
        return true
      else
        return false
      end
    end

    def nights_stayed
      return @checkout_date - @checkin_date
    end
  end # END OF CLASS
end # END OF MODULE
