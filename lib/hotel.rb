NUM_OF_ROOMS = 20

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize(rooms: [], reservations: [])
      @rooms = rooms
      @reservations = reservations
    end

    def self.all
      # .map @rooms by ID?
      return rooms
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