
class Room

    attr_reader :room_id, :cost

        def initialize(room_num, cost)
            @room_id = room_id
            @cost = cost
        end

        def all_dates
            available_room = []
        
        
        @room_id.each do |room|
            unless unavailable_room.include?(room)
                available_room << room
            end
            return available_rooms
        end
    end 


    end

end