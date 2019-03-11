require "time"

class Room
  attr_reader :number, :price, :availability

  def initialize(number, price, availability: :AVAILABLE)
    @number = number
    @price = price
    unless [:UNAVAILABLE, :AVAILABLE].include?(availability.to_sym)
      raise ArgumentError, "Invalid status"
    else
      @availability = availability.to_sym
    end
  end

  def print_nicely
    return "Room #{number}: $#{format("%.2f", price)} per night"
  end
end
