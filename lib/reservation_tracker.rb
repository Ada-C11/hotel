# handle availabilty 
# handle rooms
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

        def book_reservation(room = nil, checkin_date, checkout_date)
            reservation = Hotel::Reservation.new(room, checkin_date, checkout_date)
            @reservations << reservation
            return reservation
        end

        def reservations_by_date(date)
            list_all_rooms = []
            @reservations.each do |reservation|
                if date == reservation.checkin_date
                    list_all_rooms << reservation
                end
        end
        return list_all_rooms
        end

        

    end # end of class
end # end of module