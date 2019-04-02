module Hotel
    class AllRooms
      attr_reader :all_rooms
  
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

       def rooms_not_reserved(check_in_date, check_out_date)
        available_rooms = []
        @all_rooms.each do |room|
            if room.available_on_these_dates?(check_in_date, check_out_date) == true
                available_rooms << room
            end
            return available_rooms
        end

       end
       
    end  
       
  
end      