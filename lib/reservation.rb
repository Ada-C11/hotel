class Reservation
  attr_accessor :reservation_id, :check_in_time, :check_out_time

  def initialize(reservation_id: 0, check_in_time: nil, check_out_time: nil)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
  end
end
