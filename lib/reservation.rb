class Reservation
  attr_reader :reservation_id, :check_in, :check_out

  def initialize(reservation_id, check_in: nil, check_out: nil)
    @reservation_id = reservation_id
    @check_in = check_in
    @check_out = check_out
  end

  def cost
  end

  def duration
  end
end
