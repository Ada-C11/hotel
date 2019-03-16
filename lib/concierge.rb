require "date"
require "pry"

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
        
        
    def reserve_room(start_date, end_date)
      available_room = @all_rooms.find do |room| 
        room.status == :AVAILABLE
      end
      

      
      reservation = Reservation.new(
        id: @reservations.length + 1, 
        room: available_room, 
        start_date: start_date, 
        end_date: end_date
      )     
      
      @reservations << reservation
      available_room.add_reservation(reservation)                                   
    end
    
    
    def view_reservations_by_date(date)
      result = @reservations.filter {|res| res.include_date?(date)}
        return result
    end

    def self.see_all_rooms
      return @all_rooms
    end

    def view_available_rooms(date_range)
      available_rooms = []
      rooms_w_res = []
      @all_rooms.map do |room|
        if room.reservations == []
          available_rooms << room
        else
          rooms_w_res << room
          
          rooms_w_res.each do |room|
            room.reservations.each do |res|
              if (res.date_range).overlap_date_range?(date_range)
                rooms_w_res.delete(room)
              end
            end
          end
        end
        available_rooms = available_rooms + rooms_w_res
       end 
        return available_rooms  
    end

 
  end # end Concierge Class
end # end Hotel Module
