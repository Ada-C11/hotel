require 'date'

require_relative 'reservation'
require_relative 'block'

module Hotel
  class DateRange
    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      
      raise ArgumentError.new("Invalid end date") if @end_date < @start_date
    end

    def to_range
      return @range = (@start_date ... @end_date)
    end

    def is_overlapped?(date)
      if self.to_range.include?(Date.parse(date))
        return true
      else
        return false
      end
    end

    def date_count 
      return (@end_date - @start_date).to_i
    end
  end 
end 