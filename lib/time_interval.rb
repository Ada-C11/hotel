require "date"

module Hotel
  class TimeInterval
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      if check_in >= check_out
        raise ArgumentError.new("Check in time cannot be greater than or equal to check out time")
      end

      @check_in = check_in
      @check_out = check_out
    end

    def overlap?(time_interval)
      return !(time_interval.check_out <= @check_in ||
               @check_out <= time_interval.check_in)
    end

    def has_date?(date)
      return date >= @check_in && date < @check_out
    end

    def equals?(time_interval)
      return @check_in == time_interval.check_in && @check_out == time_interval.check_out
    end
  end
end
