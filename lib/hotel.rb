require_relative "room"
require_relative "booking"

class Hotel

  attr_reader :hotel_name, :number_of_rooms, :rooms, :bookings

  # Is initialized with the name of the hotel
  def initialize(hotel_name:, number_of_rooms:)
    @hotel_name = hotel_name
    @number_of_rooms = number_of_rooms
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

  # Can find specific room if provided the booking number
  def find_room_by_number(booking_number)
    room = @bookings.find {|booking| booking.reference_number == booking_number}
    return room
  end

  # Can find specific booking if provided the room number
  def find_booking_by_number(room_number)
    booking = @bookings.find {|booking| booking.room == room_number}
    return booking
  end

end
