require_relative "../spec/spec_helper"

module Hotel
  class ReservationDate
    attr_reader :check_in, :check_out
    @@confirmation_number = 123000

    def initialize(check_in:, check_out:)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      unless valid_date_range?(@check_in, @check_out)
        raise InvalidDateRangeError.new()
      end
      @@confirmation_number += 1
    end

    def valid_date_range?(check_in, check_out)
      return check_in < check_out && check_in >= Time.new.to_date
    end

    def range_of_dates
      return (check_in...check_out)
    end

    def self.confirmation_number
      return @@confirmation_number
    end
  end
end
