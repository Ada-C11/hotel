require 'date'

class DateRange
  attr_accessor :start_date, :end_date
  
  def initialize(start_date:, end_date:)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
      
    if end_date < start_date
      raise ArgumentError, "End date cannot be before start date"
    end 
  end
  
end
new = DateRange.new(start_date: "2019-3-10", end_date: "2019-2-10")
  
