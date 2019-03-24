require 'date'

module Hotel
  class Reservation
    attr_reader  :room_number, :date_range, :cost
  
    def initialize(room_number, date_range, cost: 200)
      @room_number = room_number 
      @check_in = check_in
      if check_out < check_in
        raise ArgumentError, "Check out date cannot be before check in date"
      else
        @check_out = check_out
      end
      @cost = cost

    end

    def total_cost
      days_spent = self.check_out - self.check_in
      if cost == 200
        return days_spent * 200
      else
        return days_spent * 100
      end
    end
    
  end
end