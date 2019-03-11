require_relative "room"
require_relative "date_range"

module Hotel
    class Booker
        attr_reader :rooms, :reservations

        def initialize
            @rooms = load_rooms
            @reservations = []
        end

        def load_rooms
            rooms = []
            20.times do |i|
                rooms.push(Hotel::Room.new(i+1))
            end
            return rooms
        end

        def book_room(start_date, end_date)
            
        end

        def view_reservations(date)
        end

    end
end