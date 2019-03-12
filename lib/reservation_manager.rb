require_relative "reservation"
require "pry"

class Reservation_manager
  attr_reader :reservations, :all_rooms, :make_reservation

  def initialize
    @all_rooms = all_rooms
    @reservations = []
  end

  def all_rooms
    @all_rooms = (1..20).map do |room_num|
      {
        room_number: room_num,
        dates_booked: [@check_in_time, @check_out_time],
      }
    end
    # binding.pry
  end

  def make_reservation(reservation_id: 0, check_in_time: Date.today.to_s, check_out_time: (Date.today + 1).to_s)
    @reservation_id = reservation_id
    @check_in_time = check_in_time
    @check_out_time = check_out_time
    @new_reservation = Reservation.new(reservation_id: @reservation_id, check_in_time: @check_in_time, check_out_time: @check_out_time)
    # @new_reservation.room_number = all_rooms.sample
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
end
