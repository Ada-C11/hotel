require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :start_date, :end_date, :make_reservation, :reservation_array, :rooms

  def initialize
    @reservation_array = []
    @rooms = ("1".."20").to_a
  end

  def make_reservation(start_date: Date.today, end_date: Date.today + 1, room: "0")
    @start_date = start_date
    @end_date = end_date
    @room = room
    new_reservation = Reservation.new(start_date: @start_date, end_date: @end_date, room: @room)
    @reservation_array << new_reservation
    return new_reservation
  end

  def view_all_rooms
    return @rooms
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

  def view_available_rooms(start_date: Date.today, end_date: Date.today + 1)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    date_range = (start_date..end_date).to_a
    booked_rooms = []

    date_range[0..-2].each do |date| # excluding last day of date range b/c you don't need a room that night
      @reservation_array.each do |reservation|
        if reservation.reservation_dates[0..-2].include?(date) # excluding last day of date range (like above)
          booked_rooms << reservation.room
        end
      end
    end
    available_rooms = rooms - booked_rooms
    binding.pry
    return available_rooms # these rooms are avail to book because at least one day is booked
  end
end
