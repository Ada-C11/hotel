require "date"

require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date, :total_cost, :date_range
    
    def initialize(id:, room:, start_date:, end_date:, date_range: nil)
      @id = id
      @room = room
      @start_date = start_date
      @end_date = end_date
      @date_range = date_range
      
      if Date.parse(end_date) < Date.parse(start_date)
        raise ArgumentError, "End date cannot be before start date"
      end 
    end
    
    
    def date_range
      @date_range = DateRange.new(start_date: start_date, end_date: end_date)
    end
    
    def date_range=(date_range)
      start_date = date_range.start_date
      end_date = date_range.end_date
    end
    
    def include_date?(date)
      if start_date <= date || date  >= end_date
        return true
      else
        return false
      end
    end
    
    def total_cost
      return ('%.2f' % (200.00 * duration)).to_f
    end
    
    def duration
      return (date_range.end_date - date_range.start_date).to_i
    end
    
    
  end # class Reservation
end # module Hotel