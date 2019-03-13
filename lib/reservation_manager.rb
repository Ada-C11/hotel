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
    # @room_number = room_number
    # @room_number = @all_rooms.shift
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
end
