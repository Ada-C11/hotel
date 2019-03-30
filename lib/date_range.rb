require "date"

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      if Date.parse(end_date) < Date.parse(start_date)
        raise ArgumentError, "End date cannot be before start date"
      end
    end

    def valid_date?(date_range)
      year = date_range.year
      month = date_range.month
      day = date_range.day

      if Date.valid_date?(year, month, day) == false
        raise ArgumentError, "Please enter valid dates"
      end
    end

    def include_date_range?(date_range)
      @start_date < date_range.start_date && @end_date >= date_range.end_date
    end

    def overlap?(date_range)
      if @start_date <= date_range.start_date && @end_date > date_range.start_date
        return true
      end

      if @start_date >= date_range.start_date && @start_date < date_range.end_date
        return true
      end

      return false
    end
  end # class DateRange
end
