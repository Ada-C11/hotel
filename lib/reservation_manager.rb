
class Reservation_Manager
  attr_reader :reservations

  def initialize(reservations: nil)
    @reservations = reservations || []
  end
end
