module Hotel
  HOTEL_SIZE = 20
  COST = 200.00
  class Room
    attr_reader :rm_id, :cost

    def initialize(**input)
      @rm_id = input[:rm_id]
      @cost = input[:cost]
    end
  end

  class Construction
    attr_accessor :rooms

    def initialize
      @rooms = build_new_rooms(HOTEL_SIZE)
    end

    def build_new_rooms(hotel_size)
      rooms = []
        hotel_size.times do |i|
          blueprint = {rm_id: "Room ##{i.to_s}", cost: COST}
          new_room = Hotel::Room.new(blueprint)
          rooms << new_room
          i += 1
        end
      rooms
    end
  end
end
