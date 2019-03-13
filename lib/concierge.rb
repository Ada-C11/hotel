require "date"

require_relative "room"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class Concierge
    attr_reader :all_rooms, :reservations
    
    def initialize
      @all_rooms = []
      20.times do |i|
        @all_rooms << Hotel::Room.new(room_number: i + 1)
      end
      @reservations = []
    end
        
    def reserve_room(check_in_date, check_out_date)
      available_room = @all_rooms.find do |room| 
        room.status == :AVAILABLE
        return room
      end
      reservation = Reservation.new(res_id: @reservations.length + 1, 
                                    room: available_room, 
                                    check_in_date: check_in_date, 
                                    check_out_date: check_out_date)
                                    
      available_room.add_reservation(reservation)                             
      @reservations << reservation
    end
     

    def see_all_rooms
      return "#{@all_rooms}" 
    end

    
  end # end Concierge Class
end # end Hotel Module
