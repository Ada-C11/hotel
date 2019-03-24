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


    
  end
end