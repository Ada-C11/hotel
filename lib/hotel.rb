require_relative "room"
require_relative "booking"

module HotelBooking
  class Hotel

    attr_accessor :hotel_name, :number_of_rooms, :rooms, :bookings

    # Is initialized with the name of the hotel
    def initialize(hotel_name:, number_of_rooms:)
      @hotel_name = hotel_name
      @number_of_rooms = number_of_rooms.to_i
      # Initialization create instances of rooms based on the the number of rooms indicated
      @rooms = []
      number_of_rooms.times do |room_number|
        room = Room.new(room_number)
        @rooms.push(room)
      end
      @bookings = []
    end

      # Can add an instance of room to the array of rooms
      def add_room(room)
        @rooms.push(room)
      end
    
      # Can add an instance of booking to the array of bookings
      def add_booking(booking)
        @bookings.push(booking)
      end  

  end
end