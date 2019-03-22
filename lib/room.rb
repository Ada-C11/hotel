require 'reservation'
require 'date_range'
require 'hotel'

module Hotel
    class Room
        attr_reader :room_number
        attr_accessor :room_availability

        def new_reservation(reservation)
            book_room = reserved_dates
            book_room.each do |date|
                @room_availability << night
            end
        end
        
        def initialize(room_number)
            @room_number = room_number
            @room_availability = []
        end
    end
end
