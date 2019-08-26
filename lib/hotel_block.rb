require "date"

class Block 
  class NoRoomError < StandardError ; end
  attr_reader :rooms, :block_size, :room_rate

  def initialize(rooms, start_date, end_date, rate)
    if rooms.empty?
      raise ArgumentError, "Can't creat a block without any rooms"
    end
    @rooms = rooms
    @available_rooms = rooms.dup
    @room_rate = room_rate
    @reserved_rooms = []
  end

  def has_rooms?
    return @available_rooms.length > 0
  end
  def reserve_room
    unless has_rooms?
      raise NoRoomError, " All rooms are reserved."
    end
    room = @available_rooms.pop
    @reserved_rooms << room
    return room
  end  

end
