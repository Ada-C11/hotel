require "date"

class HotelBlock
  attr_reader :start_date, :end_date, :rooms, :discounted_rate

  def initialize(start_date:, end_date:, rooms:, discounted_rate:)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    if @start_date > @end_date
      raise ArgumentError, "The start_date should be before the end_date"
    end
    @rooms = rooms
    if @rooms.length > 5
      raise ArgumentError, "HotelBlock can only reserve with a maximum of 5 rooms"
    end
    @discounted_rate = discounted_rate
  end

  def is_overlap?(start_date, end_date)
    return @end_date > start_date && @start_date < end_date
  end

  def same_daterange?(start_date, end_date)
    return @start_date == start_date && @end_date == end_date
  end
end
