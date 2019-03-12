require 'date'
# require_relative 'hotel.rb'

module Booking
  class Reservation < Hotel
      ROOM_COST = 200
      attr_reader :room_number, :checkin_date, :checkout_date, :total_cost
  
      def initialize(room_number, checkin_date, checkout_date)
        @room_number = room_number
        @checkin_date = checkin_date

        if checkout_date < checkin_date
          raise ArgumentError, "Check-out can't be before check-in."
        else
          @checkout_date = checkout_date
        end

        @total_cost = self.total_cost
      end
  
      def total_cost
        days_spent = (self.checkout_date - self.checkin_date)
        total = (days_spent)*ROOM_COST
        return total
      end
  end
end
