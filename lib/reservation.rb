require 'date'
require_relative 'date_range'

module Hotel
  class Reservation < Date_Range
      attr_reader :room_number, :cost
  
      def initialize(room_number, checkin_date, checkout_date, cost)
        @room_number = room_number
        @cost = cost
        super(checkin_date, checkout_date)
      end
  
      def total_cost
       return nights_stayed * @cost
      end
  end
end
