class Room 
  attr_accessor :number, :rate, :room_reservations, :blocked

  def initialize(number, room_reservations:, blocked: false)
    @number = number
    @room_reservations = []
    @blocked = blocked
  end
end

