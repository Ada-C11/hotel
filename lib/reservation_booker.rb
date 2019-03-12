require_relative "reservation"
require_relative "all_rooms"
require_relative "date_range"
require_relative "room"

module Hotel
  class ReservationBooker

    def initialize
      @all_rooms = Hotel::AllRooms.new
      @all_reservations = []
    end 

    def create_new_reservation(check_in_date, check_out_date)
      is_valid = Hotel::DateRange.valid_dates?(check_in_date, check_out_date)
      if !is_valid
        raise ArgumentError, "Invalid Dates"
      end
      
      room = @all_rooms.get_room
      reservation = Hotel::Reservation.new(check_in_date, check_out_date, room)
      @all_reservations << reservation
      return reservation
    end

    def list_all_rooms
      return @all_rooms.list_all_rooms
    end

    def reservations_by_date(date)
      reservations = []
      @all_reservations.each do |reservation|
        if Hotel::DateRange.within_range(reservation.check_in_date, reservation.check_out_date, date)
          reservations << reservation
        end

      end
      return reservations
    end

    def total_cost_by_reservation(reservation)
      return reservation.total_cost
    end
  end
end
 