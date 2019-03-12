require "date"

module Hotel
  class DateSpan
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      raise ArgumentError, "Check-in must be after today." unless @check_in > Date.today
      raise ArgumentError, "Check-out must be after check-in." unless @check_in < @check_out
    end

    def stay_length
      stay_length = (@check_out - @check_in).to_i
      return stay_length
    end

    def includes_date?(date)
      return date.between?(check_in, check_out)
    end

    def overlaps?(range)
      overlap = @check_in < range.check_out && range.check_in < @check_out
      return overlap
    end
  end
end
