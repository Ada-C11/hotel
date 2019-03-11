module HotelSystem
    
    class Room
        attr_reader :room_number
        attr_accessor :cost_per_night

        def initialize(number)
            @room_number = number
            @cost_per_night = 200
        end
    end
end