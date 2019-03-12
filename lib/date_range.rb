module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      raise ArgumentError, "invalid date" if @end_date <= @start_date
    end

    def range
      return (start_date...end_date)
    end

    def duration
      return range.count
    end

    def overlap?(date)
      return range.include?(date)
    end
  end
end
