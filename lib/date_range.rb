require 'date'

class DateRange
  attr_accessor :start_date, :end_date
  
  def initialize(start_date:, end_date:)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
  end
  
  def include_date_range?(date_range)
    start_date <= date_range.start_date && end_date >= date_range.end_date
  end

  def overlap_date_range?(date_range)
    start_date <= date_range.end_date && end_date >= date_range.start_date
  end
  
  def duration(start_date, end_date)
    return @end_date - @start_date
  end
  
end # class DateRange
  
