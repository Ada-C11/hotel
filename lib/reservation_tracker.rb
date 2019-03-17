# return reservation.cost
# handle availabilty 
# handle rooms
# booking reservations
# finding by date
# room availability
module Hotel 
 
    class ReservationTracker
        attr_reader :reservations, :all_rooms, :all_availabile, :block_reservation

        def initialize(max_rooms)
            if max_rooms > 20 
                raise ArgumentError, "this hotel is too large, max 20 rooms"
            else 
                @all_rooms = [*1..max_rooms]
            end

            @reservations = []
            @all_availabile = []
            
        end
    end
end