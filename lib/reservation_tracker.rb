class ReservationTracker
  attr_reader :total_room
  attr_accessor :room, :reservation, :date

  def initialize
    @room = room
    @reservation = reservation
    @date = date
    connect_reservation
    @total_room = total_room
  end

  def total_room
    return @total_room = (1..20).to_a
  end
end
