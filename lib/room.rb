require_relative 'hotel'

class Room

  attr_reader :number

  # is initialized with a room number as a parameter
  def initialize(number)
    @number = number
  end
  
end
