class FrontDesk
  NUMBER_OF_ROOMS = 20

  attr_reader :rooms_array

  def initialize
    # @rooms = Room.list
  end

  def rooms
    rooms_array = []
    NUMBER_OF_ROOMS.times do |i|
      rooms_array << Room.new(i + 1)
    end
    return rooms_array
  end

  def reserve
    Reservation.new
  end
end
