require_relative "all_rooms"

module Hotel
    class Reservation
      attr_reader
      def initialize(check_in_date, check_out_date, room)
        @check_in_date = check_in_date
        @check_out_date = check_out_date
        @room = room
        @room.add_reservation(self)
      end

      def  

      end

      def length_of_stay
        return (Hotel::DateRange.date_range(@check_in_date, @check_out_date).length - 1)
      end
  
      def total_cost
        return length_of_stay * @room.cost
      end
    end
  end
end    