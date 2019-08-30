require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out
    
    def initialize(check_in, check_out)
      @check_in = check_in
  
      if check_out < check_in
        raise ArgumentError, "Check-out date cannot be before check-in date"
      else
        @check_out = check_out
      end

      if total_stay <= 0
        raise ArgumentError, "Invalid date range provided."
      end
    end

    def total_stay
      total_nights = (check_out - check_in).to_i
      return total_nights
    end

    def date_check(date)
      valid_date = (date >= @check_in && date < @check_out)
      return valid_date
    end
    
    def dates_overlap?(check_in, check_out)
      valid_daterange =  date_check(check_in) || date_check(check_out) ||
      (check_in < @check_in && check_out > @check_out)
      return valid_daterange
    end
  end
end