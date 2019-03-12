require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :reservation_id, :start_date, :end_date, :make_reservation, :reservations_array

  def initialize
    @reservations_array = []
  end

  def make_reservation(reservation_id: 0, start_date: nil, end_date: nil)
    @reservation_id = reservation_id
    @start_date = start_date
    @end_date = end_date
    new_reservation = Reservation.new(reservation_id: @reservation_id, start_date: @start_date, end_date: @end_date)
    @reservations_array << new_reservation
    return new_reservation
  end

  def view_all_rooms
    reservation = Reservation.new
    return reservation.rooms
  end
end
