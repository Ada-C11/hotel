require_relative "all_rooms"

module Hotel
    class Reservation
      attr_reader :check_in_date, :check_out_date, :room
      def initialize(check_in_date, check_out_date, room)
        @check_in_date = check_in_date
        @check_out_date = check_out_date
        @room = room
        @room.add_reservation(self)
      end

      def length_of_stay
        return (Hotel::DateRange.date_range(@check_in_date, @check_out_date).length)
      end
  
      def total_cost
        return length_of_stay * @room.cost
      end
    end
end    