require_relative 'room'

class Hotel

  attr_reader :hotel_name, :rooms

  # Is initialized with the name of the hotel
  def initialize(hotel_name)
    @hotel_name = hotel_name
    @rooms = []
  end

  # Can add an instance of room to the array of rooms
  def add_room(room)
    @rooms.push(room)
  end

end

  # Can list all the rooms
  def list_rooms
    counter = 1
    list_rooms = []
    list_rooms.push("hotel_name")
    @rooms.each do |room|
      list_rooms.push("#{counter}: #{room.number}")
      counter += 1
    end
    return list_rooms.join("\n")
  end

  # Can find specific room if provided the room number
  def find_room_by_number(room_number)
    room = @rooms.find {|room| room.number == room_number}
    return room
  end

# end