require "date"

require_relative "room"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class Concierge
    attr_reader :all_rooms, :reservations
    
    def initialize(all_rooms:, reservations:)
      @all_rooms = all_rooms
      @reservations = []
    end
        
    def reserve_room(check_in_date, check_out_date)
      # check date range against date ranges in room.reservations
      reserved_room = all_rooms.select { |room| room.status == :AVAILABLE }  
    end
        
    def add_reservation(reservation_id)
      res_id.room.reservations << reservation_id
    end
        
    def self.all_rooms
      all_rooms = []
      i = 0
      20.times do |i|
        all_rooms << Hotel::Room.new(room_number: i+1)
      end
        return all_rooms
    end 
    
    def see_all_rooms
      return "#{all_rooms}" 
    end
  
    
    # def reserve_room(check_in_date, check_out_date)
    #   date_range = DateRange.new(start_date: check_in_date, end_date: check_out_date)
    #   reserved_room = @rooms.select { |room| room.status == :AVAILABLE}
    # end
    
  end # end Concierge Class
end # end Hotel Module
