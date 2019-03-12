require_relative "reservation"

class Room
  attr_accessor :number, :price, :reservations

  def initialize(number, price)
    @number = number
    @price = price

    @reservations = []
  end

  def add_reservation(res)
    if !is_available?(res.start_time, res.end_time)
      raise ArgumentError, "Room is already reserved for this date range"
    end
    reservations << res
  end

  def is_available?(start_time, end_time)
    reservations.each do |res|
      if !(res.start_time >= end_time || res.end_time <= start_time)
        return false
      end
    end
    return true
  end

  def print_nicely
    return "Room #{number}: $#{format("%.2f", price)} per night"
  end
end
