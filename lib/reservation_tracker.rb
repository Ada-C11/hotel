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

#reservation methods 

        def book_reservation(room, checkin_date, checkout_date)
            reservation = Hotel::Reservation.new(room, checkin_date, checkout_date)
            @reservations << reservation
            return reservation
        end

        def reservations_by_date(date)
        #
        end
    end
end