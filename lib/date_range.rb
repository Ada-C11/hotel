require "date"

module HotelSystem
  class DateRange
    attr_reader :start_year, :start_month, :start_day, :num_nights

    def initialize(start_year:, start_month:, start_day:, num_nights: nil)
      @start_year = start_year
      @start_month = start_month
      @start_day = start_day
      @num_nights = num_nights
    end

    def date_list
      dates_array = []
      start_date = Date.new(start_year, start_month, start_day)
      dates_array << start_date
      if num_nights
        i = 1
        num_nights.times do
          date = start_date + i
          dates_array << date
          i += 1
        end
      end
      return dates_array
    end

    def include?(date)
      if date.class != Date
        raise ArgumentError, "Please enter an instance of the Date class."
      end
      if self.date_list.include?(date)
        return true
      else
        return false
      end
    end
  end
end
