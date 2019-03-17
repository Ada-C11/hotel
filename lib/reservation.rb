require 'date'

module Hotel
  class Reservation

      attr_reader :room_number, :checkin_date, :checkout_date, :cost

      def initialize(room_number, checkin_date, checkout_date, cost: 200)
        # check_date_range(checkin_date, checkout_date)
        @room_number = room_number
        @checkin_date = checkin_date
        if checkout_date < checkin_date
          raise ArgumentError, "check out cannot happen before check in"
        else  
          @checkout_date = checkout_date
        end
        @cost = cost
      end

      def total_cost 
        days_spent = checkout_date - checkin_date
        total = days_spent * 200
        return total.to_i
      end   # end of method  
      
      # def 
      #   
      # end 
  end # end of class
end # end of module
