class Room
  attr_reader :id, :reservation_list

  def initialize(id)
    @id = id
    @reservation_list = Array.new
  end

  def reserve(time_interval)
    new_reservation = Reservation.new(time_interval)
    @reservation_list << new_reservation
  end

end