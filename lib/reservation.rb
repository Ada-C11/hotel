require 'date'

module Booking
  class Reservation
      ROOM_COST = 200
      attr_reader :room_number, :checkin_date, :checkout_date, :total_cost, :status
  
      def initialize(room_number, checkin_date, checkout_date, status: :AVAILABLE)
        @avail_statuses = [:AVAILABLE, :BOOKED]
        @room_number = room_number
        @checkin_date = checkin_date
        @checkout_date = checkout_date

        # if @checkout_date != nil && (@checkin_date > @checkout_date)
        #   raise ArgumentError, "Check-out can't be before check-in."
        # end

        @total_cost = self.total_cost
      end
  
      def total_cost
        days_spent = (self.checkout_date - self.checkin_date)
        total = (days_spent)*ROOM_COST
        return total
      end

      def add_reservation(reservation)
        @reservations << reservation
      end
  end
end
