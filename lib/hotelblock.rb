require_relative "reservation"
require_relative "room"

class HotelBlock
  attr_reader :discount, :id, :start_time, :end_time, :rooms

  def initialize(id, start_time, end_time, rooms)
    @discount = 0.2
    @id = id
    @start_time = start_time
    @end_time = end_time

    if rooms.count > 5
      raise ArgumentError, "Maximum of 5 rooms allowed in a block"
    end
    room_hash = {}
    rooms.each do |room|
      room.price -= room.price * discount

      room_hash[room] = :AVAILABLE
    end
    @rooms = room_hash
  end

  def set_unavailable(room)
    rooms[room] = :UNAVAILABLE
  end

  def rooms_available?
    rooms.each do |k, v|
      puts v
      if v == :AVAILABLE
        return true
      end
    end
    return false
  end

  def print_nicely
    formatted_rooms = ""
    rooms.each do |k, v|
      formatted_rooms << "Room #{k.number}: #{v}, price $#{format("%.2f", k.price)}; "
    end
    return "Block #{id}: #{formatted_rooms}"
  end
end
