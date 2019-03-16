require 'date'

class DateRange
  attr_accessor :start_date, :end_date
  
  def initialize(start_date:, end_date:)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
  end
  
  def include_date?(date)
    @start_date <= date >= @end_date
  end
  
  def include_date_range?(date_range)
    @start_date < date_range.start_date && @end_date >= date_range.end_date
  end

  def overlap_date_range?(date_range)
    if @start_date <= date_range.start_date && @end_date > date_range.start_date
      return true
    end
      
    if @start_date >= date_range.start_date && @start_date < date_range.end_date
      return true
    end

    return false
  end
  
  

  
end # class DateRange
  
