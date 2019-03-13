require "date"

require_relative "room"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :res_id, :room, :check_in_date, :check_out_date, :total_cost
    
    def initialize(res_id:, room:, check_in_date:, check_out_date:)
      @res_id = res_id
      @room = room
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @date_range = date_range
      
      if check_out_date < check_in_date
        raise ArgumentError, "End date cannot be before start date"
      end 
    end
    
    def date_range
        DateRange.new(start_date: check_in_date, end_date: check_out_date)
    end

    def date_range=(date_range)
      check_in_date = date_range.start_date
      check_out_date = date_range.end_date
    end
    
    def length_of_stay(reservation_id)
      return (check_out_date - check_in_date).to_i
    end
    
    def total_cost(reservation_id)
      return (200 * length_of_stay).to_f
    end
    
    
    
    
  end # class Reservation
end # module Hotel

# reservation = Hotel::Reservation.new(id: 1, room: 5, check_in_date:"2019-1-1", check_out_date:"2019-1-4")

