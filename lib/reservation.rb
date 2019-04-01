require_relative "room"

require "date"

class Reservation
  class InvalidDateRange < StandardError ; end

  attr_reader :room, :rate, :start_date, :end_date, :dates

  def initialize(room, start_date, end_date, rate)
    @start_date = start_date
    @end_date = end_date
    @room = room
    @dates = date_range
    unless end_date > start_date
      raise InvalidDateRange.new("Invalid dates #{@start_date} to #{@end_date}")
    end

    @rate = rate
  end

  def date_range
    dates = []
    number_of_dates = (@end_date - @start_date).to_i
    i = 0
    number_of_dates.times do
      date = @start_date + i
      dates.push(date)
      i += 1
    end
    return dates
  end
  def price
    return (date_range.length - 1) * @rate
  end
end
