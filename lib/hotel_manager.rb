require 'date'
require 'pry'
# require_relative 'reservation.rb'
# require_relative '../spec/hotel_spec.rb'
module Booking
  class Hotel_Manager
    attr_accessor :all_reservations, :all_rooms, :available_rooms, :max_rooms

    def initialize(max_rooms)
      if max_rooms > 20
        raise ArgumentError, "Hotel can have 20 rooms max"
      else
        @all_rooms = [*1..max_rooms]
      end
      
      @all_reservations = []
      @available_rooms = []
      # @block_of_rooms = []
    end
     

      def list_rooms
        return @all_rooms
      end

    # instead of reservation as a parameter, maybe give it checkin/checkout date and room number. this method can search for availability and create a reservation based on that
    def add_reservation(checkin_date, checkout_date, room: nil)
      @all_reservations ||= []
      res_array = []
      if room == nil
        reservation = Booking::Reservation.new(check_availability(checkin_date, checkout_date).first, checkin_date, checkout_date)
      elsif room != nil
        reservation = Booking::Reservation.new(room, checkin_date, checkout_date) 
      end
      @all_reservations << reservation
      res_array << reservation
      @available_rooms - res_array
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
      # all_rooms_array = all_rooms.map do |room|
      #   room.number
      # end

      unavail_rooms = []
      all_reservations.each do |reservation|
        if (checkin_date <= reservation.checkin_date && checkout_date >= reservation.checkin_date) || 
          (checkin_date <= reservation.checkout_date && checkout_date >= reservation.checkout_date) ||
          (checkin_date >= reservation.checkin_date && checkout_date <= reservation.checkout_date)
          unavail_rooms << reservation.room_number
        end
      end
      
      @available_rooms = all_rooms - unavail_rooms
      if @available_rooms.length == 0
        raise ArgumentError, "There are no available rooms for that date."
      end
      return @available_rooms
    end

# END OF CLASS
  end
# END OF MODULE
end

