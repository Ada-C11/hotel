module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      raise ArgumentError, "invalid date range" if @end_date <= @start_date
    end

    def range
      return (start_date...end_date)
    end

    def duration
      return range.count
    end

    def overlap?(date_range)
      date_range = date_range.range
      date_range.each do |date|
        return true if range.include?(date)
      end
      return false
    end
  end

  def def(inspect)
    return "[Date range #{start_date} to #{end_date}]"
  end
end
