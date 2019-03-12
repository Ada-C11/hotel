module Hotel
    class AllRooms
      attr_reader
  
      def initialize
        room_number = 1
        @all_rooms = []
        20.times do
            room = Hotel::Room.new(room_number, 200)
            @all_rooms << room 
            room_number += 1
        end
      end

      def get_room
        return @all_rooms.sample
      end


      def list_all_rooms
        return @all_rooms
       end

       def rooms_not_reserved(date)

       end

       def reservations_by_date(date)

       end
  
      
    end 
      

end     