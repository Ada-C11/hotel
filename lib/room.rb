require "time"

class Room
  attr_reader :number, :price, :availability

  def initialize(number, price, availability: :AVAILABLE)
    @number = number
    @price = price
  end
end
