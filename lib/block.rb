module Hotel

    class Block
        attr_reader :id 

        attr_accessor :block_reservations

        def initialize(block_reservations: ,id: )
            @id = id
            @block_reservations = {}
            block_reservations.each do |block_reservation|
                @block_reservations[block_reservation] = :available
            end
        end

        def reserve_block_room
        end

        def block_room_available?(block_reservation)
            status = block_reservations[block_reservation]
            return status
        end

    end
end