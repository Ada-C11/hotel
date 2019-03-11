require_relative "reservation"

class Reservation_manager
  attr_accessor :make_reservation

  def initialize
    @reservations = []
  end

  def make_reservation(reservation_id: 0, check_in_time: nil, check_out_time: nil)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    new_reservation = Reservation.new(reservation_id: @reservation_id, check_in_time: @check_in_time, check_out_time: @check_out_time)
    @reservations << new_reservation
    return new_reservation
  end
end
