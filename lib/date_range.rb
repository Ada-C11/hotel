require 'date'

require_relative 'reservation'
require_relative 'block'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date
    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      
      raise ArgumentError.new("Invalid end date") if @end_date < @start_date
    end

    def to_range
      return @range = (@start_date ... @end_date)
    end

    def is_included?(date)
      if self.to_range.include?(Date.parse(date))
        return true
      else
        return false
      end
    end

    def is_overlapped?(start_date, end_date)
      range_array = (Date.parse(start_date)...Date.parse(end_date)).to_a
      range_array.each do |date|
        if self.to_range.include?(date) 
          return true
        end
      end
      return false
    end


    def date_count 
      return (@end_date - @start_date).to_i
    end
  end 
end 