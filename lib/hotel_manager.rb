require 'date'
require 'pry'

module Booking
  class Hotel_Manager
    attr_accessor :all_reservations, :all_rooms, :available_rooms, :all_blocks

    def initialize(max_rooms)
      if max_rooms > 20
        raise ArgumentError, "Hotel can have 20 rooms max"
      else
        @all_rooms = [*1..max_rooms]
      end
      @all_reservations = []
      @available_rooms = []
      @all_blocks = [] 
    end

    
    def add_reservation(checkin_date, checkout_date, room: nil, cost: 200)
      @all_reservations ||= []
      res_array = []
      if room == nil
        reservation = Booking::Reservation.new(check_availability(checkin_date, checkout_date).first, checkin_date, checkout_date)
      elsif room != nil
        reservation = Booking::Reservation.new(room, checkin_date, checkout_date) 
      end
      @all_reservations << reservation
      res_array << reservation.room_number
      
      @available_rooms = check_availability(checkin_date, checkout_date) - res_array

      return reservation
    end

    def reservations_by_date(date)
      list = []
      @all_reservations.each do |reservation|
        if date == reservation.checkin_date
          list << reservation
        end
      end
      return list
    end

    def check_availability(checkin_date, checkout_date)
      unavail_rooms = []
      all_reservations.each do |reservation|
        if (checkin_date <= reservation.checkin_date && checkout_date >= reservation.checkin_date) || 
          (checkin_date <= reservation.checkout_date && checkout_date >= reservation.checkout_date) ||
          (checkin_date >= reservation.checkin_date && checkout_date <= reservation.checkout_date)
          
            unavail_rooms << reservation.room_number
        end
      end
      if @available_rooms == nil
        raise ArgumentError, "There are no available rooms for that date."
      else
        @available_rooms = all_rooms - unavail_rooms
      end
      
      return @available_rooms
    end
    
# END OF CLASS
  end
# END OF MODULE
end

