require_relative "reservation"

class Room
  attr_accessor :number, :price, :reservations, :unavailable_dates

  def initialize(number, price)
    @number = number
    @price = price
    @unavailable_dates = []
    @reservations = []
  end

  def add_reservation(res)
    if !is_available?(res.start_time, res.end_time)
      raise ArgumentError, "Room is already reserved for this date range"
    end
    reservations << res
    unavailable_dates << [res.start_time, res.end_time]
  end

  def is_available?(start_time, end_time)
    if unavailable_dates == []
      return true
    end
    unavailable_dates.each do |date_array|
      if !(date_array[0] >= end_time || date_array[1] <= start_time)
        return false
      end
    end
    return true
  end

  def print_nicely
    return "Room #{number}: $#{format("%.2f", price)} per night"
  end
end
