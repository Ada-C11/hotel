require_relative 'room'

class Hotel

  attr_reader :hotel_name, :rooms, :number_of_rooms

  # Is initialized with the name of the hotel
  def initialize(hotel_name:, number_of_rooms:)
    @hotel_name = hotel_name
    @number_of_rooms = number_of_rooms

    @rooms = []
    number_of_rooms.times do |room_number|
      room = Room.new(room_number)
      @rooms.push(room)
    end
  end

  # Can add an instance of room to the array of rooms
  def add_room(room)
    @rooms.push(room)
  end

  # Can find specific room if provided the room number
  def find_room_by_number(room_number)
    room = @rooms.find {|room| room.number == room_number}
    return room
  end

end
