require_relative "reservation"

class Reservation_manager
  attr_accessor :make_reservation
  attr_reader :reservations, :all_rooms

  def initialize
    @all_rooms = (1..20).to_a
    @reservations = []
  end

  def make_reservation(reservation_id: 0, check_in_time: nil, check_out_time: nil)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    @new_reservation = Reservation.new(reservation_id: @reservation_id, check_in_time: @check_in_time, check_out_time: @check_out_time)
    @reservations << @new_reservation
    return @new_reservation
  end

  def find_reservations(date)
    # given date, return reservations who have date somewhere in between
    # reservation's check in or out times
    reservations_with_date = []
    if date.between?(@check_in_time, @check_out_time)
      reservations_with_date << @new_reservation
      # OR pull the instances from the reservations array
    end
    return reservations_with_date
    # this only returns last instance of reservation though :/
  end
end
