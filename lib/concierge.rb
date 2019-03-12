require "date"

require_relative "room"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class Concierge
    attr_reader :rooms, :reservations
    
    def initialize(rooms:, reservations:)
      @rooms = room.create_hotel
      @reservations = []
    end
        
    
    def see_all_rooms
      return @rooms  
    end
  
    def reserve_room(check_in_date, check_out_date)
      date_range = DateRange.new(start_date: check_in_date, end_date: check_out_date)
      reserved_room = @rooms.select { |room| room.status == :AVAILABLE}
    end
    
  end
end
