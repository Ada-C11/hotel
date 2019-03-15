require_relative "reservation.rb"
require "date"
require "pry"

module Hotel
  class ReservationManager
    #add constant for room numbers
    def initialize
      @reservations = []
    end

    def all_rooms
      rooms = (1..20).to_a
      return rooms
    end

    def make_reservation(check_in, check_out)
      room_number = available_rooms(check_in, check_out).first
      new_reservation = Hotel::Reservation.new(room_number,
                                               check_in,
                                               check_out)

      @reservations << new_reservation

      return new_reservation
    end

    def reservations_by_date(start_date, end_date)
      s_date = Date.parse(start_date)
      e_date = Date.parse(end_date)
      reservations_by_date = []
      @reservations.each do |reservation|
        if e_date > reservation.check_in && e_date <= reservation.check_out
          reservations_by_date << reservation
        elsif s_date >= reservation.check_in && s_date < reservation.check_out
          reservations_by_date << reservation
        elsif s_date <= reservation.check_in && e_date >= reservation.check_out
          reservations_by_date << reservation

          #Right now checkout day is not included because you can check-in on that day
        end
      end

      return reservations_by_date
    end

    def available_rooms(start_date, end_date)
      unavail_rooms = reservations_by_date(start_date, end_date).map do |reservation|
        reservation.room_number
      end

      avail_rooms = all_rooms.reject { |rm_num| unavail_rooms.include? rm_num }

      return avail_rooms
    end
  end
end
