class Room
  attr_reader :id, :cost_per_night, :reservation_list
  COST_PER_NIGHT = 200.00
  private_constant :COST_PER_NIGHT

  def initialize(id)
    @id = id
    @reservation_list = Array.new
  end

  def reserve(time_interval)
    new_reservation = Reservation.new(time_interval)
    @reservation_list << new_reservation
  end

  def list_reservations(date)

  end

end