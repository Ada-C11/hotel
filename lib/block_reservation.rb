module Hotel

    class Block_Reservation
        attr_reader :date_range, :id

        attr_accessor :room, :cost

        def initialize(id: , date_range: , room: nil, cost: 200, block: nil)
            @id = id
            @date_range = date_range
            @room = room
            @cost = cost
            @block = block
        end

    end
end