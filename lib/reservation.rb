require 'rooms.rb'
require 'date_range.rb'

module Hotel
  class Reservation
    attr_reader :check_in, :total_nights
    attr_accessor :name, :room_number, :check_out, :reserved_dates

    def find_available_rooms(dates)
      available_rooms = []
      @rooms.each do |room|
        overlap = room.availability & dates
        if overlap.length == 0
          available_rooms << room
        end
      end
      return available_rooms
    end

    def assign_room_number(reservation)
      available_rooms = find_available_rooms(reservation.reserved_nights)
      if available_rooms.length == 0
        raise ArgumentError, "No available rooms for requested dates."
      else
        room_assignment = available_rooms.first
        reservation.room_num = room_assignment.number
        room_assignment.add_reservation(reservation)
      end
    end

    def find_reservation_by_date(date)
      reservations_by_date = @reservations.find_all { |reservation| reservation.reserved_nights.include?(Date.parse(date)) }
    end

    def initialize(name, check_in, total_nights)
      @name = name
      @check_in = Date.parse(check_in)

      if total_nights >= 1
        @total_nights = total_nights
      else 
        raise ArgumentError, "Please reserve at least one night."
      end
    
      @check_out = @check_in + total_nights
      @reserved_dates = total_reserved_nights
      @room_number = nil
    end

    def cost
      return total_nights * 200 
    end

    def total_reserved_nights
      reserved_dates = []
      counter = 0
      total_nights.times do 
        reserved_dates = @check_in + counter
        counter += 1
      end
      return reserved_dates
    end
  end
end


# @room_price = 200
# def make_reservation(start_date, end_date)
#     # Validate the date range.
#     validate_date_range(start_date, end_date)
#     # Find room thats available.
#     overlapping_reservations = @reservations.find_all #help help help
#     # Create reservation
#     reservation = Reservation.new(room_number,start_date,end_date)
#     # Store the reservation.
#     reservations << reservation
#     # Return the reservation.
#     return reservation
#   end


