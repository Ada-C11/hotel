require_relative "reservation"
require "pry"

class Reservation_manager
  attr_reader :reservations, :all_rooms, :make_reservation

  def initialize
    @reservations = []
  end

  def make_reservation(reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    @new_reservation = Reservation.new(reservation_id: @reservation_id, check_in_time: @check_in_time, check_out_time: @check_out_time)
    @reservations << @new_reservation
    # binding.pry
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

  def find_available_rooms(check_in_time, check_out_time)
    available_rooms = (1..20).to_a
    check_in = Date.parse(check_in_time)
    check_out = Date.parse(check_out_time)

    date_range_of_interest = (check_in...check_out).to_a

    @reservations.each do |reservation|
      date_range = (reservation.check_in_time...reservation.check_out_time).to_a
      combined_range = date_range + date_range_of_interest

      if combined_range.length != combined_range.uniq.length
        available_rooms.delete(reservation.room_number)
      end
    end

    return available_rooms
  end
end
