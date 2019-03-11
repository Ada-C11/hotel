module Hotel
    class Room
        attr_reader :room_number, :status

        COST = 200.00

        def initialize(room_number, status: :AVAILABLE)
            @room_number = room_number
            @status = status.to_sym
        end

        # def availability(range_of_date)

        # end
    end
end