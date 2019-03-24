require 'date'

module Hotel
  class ReservationManager
    attr_reader :reservations, :block_reservations

    def initialize
      @reservations = []
      @block_reservations = []
    end

    def hotel_rooms
      rooms = [*1..20]
      return rooms 
    end

    #  basic reservation methods
    def book_reservation(room, date_range)
      # raising the error but test says nothing was raised
      # unless room_availability(date_range.check_in, date_range.check_out).include?(room)
      #   raise ArgumentError, "The room you've selected is not available for these dates."
      # end
      reservation = Hotel::Reservation.new(room, date_range)
      @reservations << reservation
      return reservation
    end

    # check if a date range has been taken and store it in booked rooms array
    def room_availability(check_in, check_out)
      booked_rooms = []
      @reservations.each do |reservation|
        if reservation.date_range.daterange_check(check_in, check_out)
          booked_rooms << reservation.room
        end
      end
      return hotel_rooms - booked_rooms
    end

    # checks each reservation by date and adds it to the reservations list
    def res_by_date(date)
      res_list = []
      @reservations.each do |reservation|
        if date == reservation.date_range.date_check(date)
          res_list << reservation
        end
      end
      return res_list
    end



    # def room_availability(check_in, check_out)
    #   booked_rooms  = []
    #   # daterange class did not have this repition
    #   @reservations.each do |reservation|
    #     # checking valid dates and date ranges 
    #     if (check_in <= reservation.check_in && check_out >= reservation.check_in) || 
    #       (check_in >= reservation.check_in && check_out <= reservation.check_out) ||
    #       (check_in <= reservation.check_out && check_out >= reservation.check_out) 
    #       booked_rooms << reservation.room_number
    #     end

    #   end

    # # available rooms equals all rooms array minus rooms that are booked
    #   @available_rooms = total_rooms - booked_rooms.uniq
    #   if @available_rooms.length == 0
    #     raise ArgumentError, "There are no available rooms for that date"
    #   end
    #     return @available_rooms         
    # end
 
  end
end 
