
# Wave One: Tracking Reservations
# In this wave, write the functionality for the system to track valid
#reservations, so that a user of the hotel system can make and find
#valid bookings for their hotel.

# Remember: Your job is to only build the classes that store info
# and handle business logic, and the tests to verify they're behaving
# as expected. Building a user interface is not part of this project!

# User Stories
# I can access the list of reservations for a specific date, so that
# I can track reservations by date

module Hotel
  class Room
    attr_reader :number
    attr_accessor :availability #, :status

    def initialize(number)
      @number = number
      @availability = []
      #@status = []
    end

    def self.all_rooms
      room_list = []
      counter = 0
      20.times do
        room = Room.new(counter + 1)
        counter += 1
        room_list << room
      end
      return room_list
    end
  end
end
