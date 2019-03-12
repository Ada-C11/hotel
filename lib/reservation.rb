require_relative "../spec/spec_helper"

module Hotel
  class ReservationDates
    attr_reader :check_in, :check_out

    def initialize(check_in:, check_out:)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      unless valid_date_range?(@check_in, @check_out)
        raise InvalidDateRangeError.new()
      end
    end

    def valid_date_range?(check_in, check_out)
      return check_in < check_out && check_in >= Time.new.to_date
    end

    def range_of_dates
      return (check_in...check_out)
    end
  end
end
