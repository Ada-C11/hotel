require 'date'
# require_relative 'hotel.rb'

module Hotel
  class Reservation
      attr_reader :room_number, :checkin_date, :checkout_date, :total_cost, :cost
  
      def initialize(room_number, checkin_date, checkout_date, cost: 200)
        @room_number = room_number
        @checkin_date = checkin_date

        if checkout_date < checkin_date
          raise ArgumentError, "Check-out can't be before check-in."
        else
          @checkout_date = checkout_date
        end
        @cost = cost
        @total_cost = total_cost
      end
  
      def total_cost
        days_spent = (checkout_date - checkin_date)
        if cost == 200
          total = (days_spent)*200
        else total = (days_spent)*cost
        end
        return total.to_i
      end
  end
end
