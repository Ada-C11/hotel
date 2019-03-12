require_relative 'room'

class Hotel

  attr_reader :hotel_name, :rooms

  def initialize(hotel_name)
    @hotel_name = hotel_name
    @rooms = []
  end

  def add_room (room)
    @rooms.push(room)
  end

end

#   def list_rooms
#     counter = 1
#     list_rooms = []
#     list_rooms.push("hotel_name")
#     @rooms.each do |room|
#       list_rooms.push("#{counter}: #{room.name}")
#       counter += 1
#     end
#     return list_rooms.join("\n")
#   end

#   def find_room_by_number(room_number)
#     room = @rooms.find {|room| room.number == room_number}
#     return room
#   end

# end