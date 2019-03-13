class Room 
  attr_accessor :number, :rate, :room_reservations

  def initialize(number, room_reservations:)
    @number = number
    @room_reservations = []
  end
end

