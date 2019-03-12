require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :start_date, :end_date, :make_reservation, :reservation_array

  def initialize
    @reservation_array = []
  end

  def make_reservation(start_date: Date.today, end_date: Date.today + 1)
    @start_date = start_date
    @end_date = end_date
    new_reservation = Reservation.new(start_date: @start_date, end_date: @end_date)
    @reservation_array << new_reservation
    return new_reservation
  end

  def view_all_rooms
    rooms = ("1".."20").to_a
    return rooms
  end

  def access_reservations_by_date(date)
    parsed_date = Date.parse(date)
    reservations_matching_date = []
    @reservation_array.each do |reservation|
      if reservation.reservation_dates.include?(parsed_date)
        reservations_matching_date << reservation
      end
    end
    return reservations_matching_date
  end
end
