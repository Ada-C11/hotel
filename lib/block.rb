require_relative 'date_range'

module Hotel
  class Block
    attr_reader :date_range, :rooms, :rate

    def initialize(start_date:, end_date:, rooms:, rate:, date_range:)
      @start_date = start_date
      @end_date = end_date
      @date_range = date_range
      @rooms = rooms
      @rate = rate
    end

    def date_range
      @date_range = DateRange.new(start_date: start_date, end_date: end_date)
   end
    
    def date_range=(date_range)
      @start_date = date_range.start_date
      @end_date = date_range.end_date
    end
  end
end