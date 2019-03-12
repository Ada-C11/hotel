require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :reservation_id, :start_date, :end_date, :make_reservation, :reservation_dates_array

  def initialize
    @reservation_dates_array = []
  end

  def make_reservation(reservation_id: 0, start_date: nil, end_date: nil)
    @reservation_id = reservation_id
    @start_date = start_date
    @end_date = end_date
    new_reservation = Reservation.new(reservation_id: @reservation_id, start_date: @start_date, end_date: @end_date)
    @reservation_dates_array << new_reservation
    return new_reservation
  end

  def view_all_rooms
    reservation = Reservation.new
    return reservation.rooms
  end

  def access_reservations_by_date(date)
    new_date = Date.parse(date)
    @reservation_dates_array.each do |reservation|
      reservation.reservation_dates.each do |each_reservation|
        if each_reservation.include?(new_date)
          #   binding.pry
        end
        return "it's included!"
      else
        return "it's not included!"
      end
    end
  end
end
