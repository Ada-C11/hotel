module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      raise ArgumentError, "invalid date" if @end_date < @start_date
    end
  end
end
