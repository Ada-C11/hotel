class Scheduler
  attr_reader :room_map

  def initialize
    @room_map = Hash.new
    20.times do
      room_id = rand(1...100)
      @room_map[room_id] = Room.new(room_id)
    end
  end

  def get_room_ids
    return @room_map.keys
  end

  def reserve_room(room_id, date_range)
    @room_map.each do |id, room|
      if room_id = id
        room.reserve(date_range)
      end
    end
  end
end