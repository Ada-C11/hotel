module HotelSystem
    
    class Room
        attr_reader :room_number
        attr_accessor :cost_per_night

        def initialize(number)
            if number.class != Integer || number <= 0
                raise ArgumentError, "Please enter a whole number greater than 0."
            end
            @room_number = number
            @cost_per_night = 200
        end
    end
end