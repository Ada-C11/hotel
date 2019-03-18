require_relative "reservation"
require_relative "all_rooms"
require_relative "date_range"
require_relative "room"

module Hotel
  class ReservationBooker
    attr_reader :all_reservations

    def initialize
      @all_rooms = Hotel::AllRooms.new
      @all_reservations = []
    end 

    def create_new_reservation(check_in_year, check_in_month, check_in_day, check_out_year, check_out_month, check_out_day)
      is_valid = Hotel::DateRange.valid_checkin_dates?(check_in_year, check_in_month, check_in_day)
      if !is_valid 
        raise ArgumentError, "Invalid Dates"
      end 

      is_valid = Hotel::DateRange.valid_checkout_dates?(check_out_year, check_out_month, check_out_day)
      if !is_valid
        raise ArgumentError, "Invalid Dates"
      end 

      check_in_date = Hotel::DateRange.check_in_date(check_in_year, check_in_month, check_in_day)
      check_out_date = Hotel::DateRange.check_out_date(check_out_year, check_out_month, check_out_day)

      is_valid = Hotel::DateRange.valid_dates?(check_in_date, check_out_date)
      if !is_valid
        raise ArgumentError, "Invalid Dates"
      end 


      rooms_not_reserved = available_rooms_by_date_range(check_in_year, check_in_month, check_in_day, check_out_year, check_out_month, check_out_day)
      room = rooms_not_reserved.sample
      
      if room.available_on_these_dates?(check_in_date, check_out_date) == false
        raise ArgumentError, "Room is not available on given dates"
      end

      reservation = Hotel::Reservation.new(check_in_date, check_out_date, room)
      @all_reservations << reservation
      return reservation  
  
    end

    def list_all_rooms
      return @all_rooms.list_all_rooms
    end

    def reservations_by_date(year, month, day)
      if Hotel::DateRange.valid_checkin_dates?(year, month, day) == false
        raise ArgumentError, "Invalid date"
      end
      date_integers = year.to_s + "/" + month.to_s + "/" + day.to_s 
      date = Date.parse(date_integers)
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

    def available_rooms_by_date_range(check_in_year, check_in_month, check_in_day, check_out_year, check_out_month, check_out_day)
      check_in_date = Hotel::DateRange.check_in_date(check_in_year, check_in_month, check_in_day)
      check_out_date = Hotel::DateRange.check_out_date(check_out_year, check_out_month, check_out_day)
      return @all_rooms.rooms_not_reserved(check_in_date, check_out_date)
    end


  end
end
 