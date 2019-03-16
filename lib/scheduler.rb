class Scheduler
  attr_reader :room_map

  def initialize(num_rooms)
    @room_map = Hash.new
    num_rooms.times do |i|
      room_id = i + 1
      @room_map[room_id] = Room.new(room_id)
    end
  end

  def get_room_ids
    return @room_map.keys
  end

  def reserve_room(room_id, date_range)
    @room_map[room_id].reserve(date_range)
  end

  def get_reservations(date)
    list = Array.new
    @room_map.each_key { |id|
      @room_map[id].get_reservations_on_date(date).each do |reservation|
        list << reservation.room_id
      end
    }
    return list
  end

  def get_available_rooms(date_range)
    list = Array.new
    @room_map.each_key { |id|
      if @room_map[id].is_available?(date_range)
        list << @room_map[id].room_id
      end
    }
    return list
  end
end