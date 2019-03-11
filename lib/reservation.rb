require "date"

require_relative "room"
require_relative "concierge"
require_relative "date_range"

module Hotel
  class Reservation
    attr_reader :id, :room, :check_in_date, :check_out_date, :length_of_stay, :total_cost
    
    def initialize(id:, room: 1, check_in_date:, check_out_date:)
      @id = id
      @room = room
      @check_in_date = check_in_date
      @length_of_stay = DateRange.new(start_date: check_in_date, end_date: check_out_date).duration.to_i
      @total_cost = (200 * length_of_stay)
    end
    
    def total_cost(reservation)
      return self.total_cost
    end
    
    
  end
end

# reservation = Hotel::Reservation.new(id: 1, room: 5, check_in_date:"2019-1-1", check_out_date:"2019-1-4")

