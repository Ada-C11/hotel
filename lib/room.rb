require "time"

class Room
  attr_reader :number, :price, :reservations

  def initialize(number, price)
    @number = number
    @price = price

    @reservations = []
  end

  def add_reservation(res)
    reservations << res
  end

  def is_available?(start_time, end_time)
    reservations.each do |res|
      if !(res.start_time >= end_time || res.end_time <= start_time)
        return false
      end
      return true
    end
  end

  def print_nicely
    return "Room #{number}: $#{format("%.2f", price)} per night"
  end
end
