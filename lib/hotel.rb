require_relative 'room'
require_relative 'reservation'

NUM_OF_ROOMS = 20

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize(rooms: [], reservations: [])
      @rooms = rooms
      @reservations = reservations
    end

    def self.list_rooms
      # all_rooms = @rooms.map {|room| room.room_num}
      # return all_rooms
    end

    def available?(date_range)
      # Iterates through date range, checking if that date for that room is blocked off
      # Return true if all returns true
    end

    def book(date_range)
      if available?(date_range)
        # Iterate through each room's bookings
        # When found, block off date range as new reservation, return room_num?
        # Add reservation to reservations
      end
    end

    def list_by_date(date)
      # Search through reservations by date
      return reservations
    end
  end
end

# test_room = BookingSystem::Room.new(room_num: 1)
# test_reservation = BookingSystem::Reservation.new(room: test_room,
#                                                   checkin_date: Date.new(2019, 1, 1),
#                                                   checkout_date: Date.new(2019, 1, 11))
# test_room.add_reservation(test_reservation)
