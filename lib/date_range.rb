require "date"
require_relative "err/errors"

module HotelSystem
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date_string, end_date_string)
      @start_date = Date.parse(start_date_string)
      @end_date = Date.parse(end_date_string)
      if (@end_date <= @start_date)
        raise DateRangeError, "End date must be after start date"
      end
    end

    def dates
      return(@start_date...@end_date).to_a
    end

    def includes_date?(date)
      return dates.include?(date)
    end

    def overlap?(other)
      return self.dates & other.dates != []
    end

    def length
      return dates.length
    end
  end
end
