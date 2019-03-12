require_relative 'hotel'

class Room

  attr_reader :number, :price

  def initialize(number:, price: 200)
    @number = number
    @price = 200
  end
  
end 
