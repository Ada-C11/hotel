
module Hotel

    class Reservation
        attr_reader :date_range, :cost, :id

        attr_accessor :room

        def initialize(id:, date_range: , room: nil)
            @id = id
            @date_range = date_range
            @room = room
            @cost = cost
        end

        def cost
            total = 200.0 * (date_range.length)
            return total
        end

    end
end