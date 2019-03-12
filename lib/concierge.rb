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
      reserved_room = Hotel::Room.new(
                                      room_number: rand(1..20), 
                                      status: :AVAILABLE, 
                                      reservations: [])
      
      reservation = Reservation.new(res_id: 1, room: reserved_room, check_in_date: check_in_date, check_out_date: check_out_date)
      
      return reservation
    end
        
    # def add_reservation(reservation_id)
    #   res_id.room.reservations << reservation_id
    # end
        
   
      

    
    def see_all_rooms
      return "#{@all_rooms}" 
    end
  
    
    # def reserve_room(check_in_date, check_out_date)
      
    #   reserved_room = all_rooms.select { |room| room.status == :AVAILABLE}
    # end
    
  end # end Concierge Class
end # end Hotel Module
