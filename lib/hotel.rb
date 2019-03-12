require 'date'
# require_relative 'reservation.rb'
# require_relative 'room.rb'

module Booking
  class Hotel
    MAX_ROOMS = 20
    attr_accessor :all_reservations, :all_rooms

    def initialize
      @all_reservations = []
      @all_rooms = [*1..20]
        @all_rooms.map! do |a|
          Room.new(a)  
        end
    end

      def list_rooms
        return @all_rooms
      end

    # instead of reservation as a parameter, maybe give it checkin/checkout date and room number. this method can search for availability and create a reservation based on that
    def add_reservation(checkin_date, checkout_date)
      @all_reservations ||= []
      reservation = Booking::Reservation.new(check_availability(checkin_date, checkout_date).first, checkin_date, checkout_date)

      @all_reservations << reservation
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
      all_rooms_array = all_rooms.map do |room|
        room.number
      end

      unavail_rooms = []
      all_reservations.each do |reservation|
        if reservation.checkin_date == checkin_date || reservation.checkout_date == checkout_date
          unavail_rooms << reservation.room_number
        end
      end
      
      available_rooms = all_rooms_array - unavail_rooms

      return available_rooms
    end
  end
    

end
