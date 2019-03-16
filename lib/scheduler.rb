module Hotel
  class Scheduler
    def initialize(num_rooms)
      @rooms = Hash.new
      num_rooms.times do |i|
        @rooms[i] = Room.new(i)
      end
    end

    def get_room_ids
      return @rooms.keys.sort
    end

    def reserve_room(room_id, date_range)
      @rooms[room_id].reserve(date_range)
    end

    def get_reservations(date)
      list = Array.new
      @rooms.each_key { |id|
        r = @rooms[id].get_reservation_on_date(date)
        if !r.nil?
          list << r
        end
      }
      return list
    end

    def get_available_rooms(date_range)
      list = Array.new
      @rooms.each_key { |id|
        if @rooms[id].is_available?(date_range)
          list << @rooms[id].room_id
        end
      }
      return list
    end
  end
end