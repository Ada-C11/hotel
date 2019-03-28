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

        def list_available_rooms
            list = block_reservations.select{|reservation, status| status == :available}
            return list
        end

        def reserve_block_room(block_reservation)
            reserve_status = false
            if block_reservations[block_reservation] == :available 
                block_reservations[block_reservation] = :unavailable 
                reserve_status = true
            end
            return reserve_status
        end

        def block_room_available?(block_reservation)
            status = block_reservations[block_reservation]
            return status
        end

    end
end