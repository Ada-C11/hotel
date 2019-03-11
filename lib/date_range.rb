require "date"

module HotelSystem
  class DateRange
    attr_reader :start_date, :end_date, :dates

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @dates = (start_date...end_date).to_a
    end
  end
end
