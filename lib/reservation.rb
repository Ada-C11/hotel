

module Hotel

    class Reservation
        attr_reader :date_range, :cost, :room, :id

        def initialize(id: , date_range: , room: nil)
            @id = id
            @date_range = date_range
            @room = room
        end

        def cost
            total = 200.0 * (date_range.length - 1)
            return total
        end

    end
end