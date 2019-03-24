require 'date'

module Hotel
  class Reservation
    attr_reader  :room_number, :date_range, :cost
  
    def initialize(room_number, date_range, cost: 200)
      @room_number = room_number 
      @date_range = date_range
      @cost = cost

    end

    def total_cost
      if cost == 200
        return @date_range.total_stay * cost
      else
        return days_spent * 100
      end
    end
    
  end
end