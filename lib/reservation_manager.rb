require_relative "reservation"
require "pry"

class Reservation_manager
  attr_reader :reservations, :all_rooms, :make_reservation

  def initialize
    @all_rooms = (1..20).to_a
    @reservations = []
  end

  def make_reservation(reservation_id: 0, check_in_time: Date.today, check_out_time: (Date.today + 1))
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    @new_reservation = Reservation.new(reservation_id: @reservation_id, check_in_time: @check_in_time, check_out_time: @check_out_time)
    @reservations << @new_reservation
    return @new_reservation
  end

  def find_reservations(date)
    date = Date.parse(date)
    reservations_with_date = @reservations.select do |reservation|
      if date.between?(reservation.check_in_time, reservation.check_out_time)
        @new_reservation
      end
    end
    return reservations_with_date
  end
end
