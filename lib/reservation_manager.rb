require 'date'

module Hotel
  class ReservationManager
    attr_reader :reservations, :block_reservations, :total_rooms, :available_rooms

    def initialize(max_rooms)
      if max_rooms > 20
        raise ArgumentError, "Hotel can only be 20 rooms maximum."
      else
        @total_rooms = [*1..max_rooms] 
      end
      @reservations = []
      @block_reservations = []
    end

    #  basic reservation methods
    def book_reservation(room = nil, check_in, check_out)
      @reservations ||= []
      stored_reservations = []
      
      # if the room is nil, create a new reservation and make it first item in array
      room == nil ? reservation = Hotel::Reservation.new(room_availability(check_in, check_out).first, check_in, check_out) : reservation = Hotel::Reservation.new(room, check_in, check_out) 
      
      @reservations << reservation
      stored_reservations << reservation

      @total_rooms - stored_reservations.uniq
      return reservation
    end

    def room_availability(check_in, check_out)
      booked_rooms  = []
      # daterange class did not have this repition
      @reservations.each do |reservation|
        # checking valid dates and date ranges 
        if (check_in <= reservation.check_in && check_out >= reservation.check_in) || 
          (check_in >= reservation.check_in && check_out <= reservation.check_out) ||
          (check_in <= reservation.check_out && check_out >= reservation.check_out) 
          booked_rooms << reservation.room_number
        end

      end

    # available rooms equals all rooms array minus rooms that are booked
      @available_rooms = total_rooms - booked_rooms.uniq
      if @available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for that date"
      end
        return @available_rooms         
    end


    def res_by_date(date)
      res_list = []
      @reservations.each do |reservation|
        if date == reservation.check_in
          res_list << reservation
        end
      end
      return res_list
    end
 
  end

  # not able to create a pull request?
end  
