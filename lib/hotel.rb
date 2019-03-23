module HotelBooking
  class Hotel
    attr_accessor :hotel_name, :number_of_rooms, :rooms, :bookings

    def initialize(hotel_name:, number_of_rooms:)
      @hotel_name = hotel_name
      @number_of_rooms = number_of_rooms.to_i
      @rooms = []
      number_of_rooms.times do |room_number|
        room = Room.new(room_number)
        @rooms.push(room)
      end
      @bookings = []
    end

    def add_room(room)
      @rooms.push(room)
    end

    def add_booking(booking)
      @bookings.push(booking)
    end
  end

end