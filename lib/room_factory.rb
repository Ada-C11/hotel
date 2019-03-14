module Hotel

#   class Room
#     attr_reader :rm_id, :cost

#     def initialize(**input)
#       @rm_id = input[:rm_id]
#       @cost = input[:cost]
#     end
#   end
# end

module Construction
  HOTEL_SIZE = 20
  COST = 200.00
    attr_accessor :all_rooms

    def initialize
      @all_rooms = build_new_hotel(HOTEL_SIZE)
    end

    def build_new_hotel(hotel_size)
      rooms = []
      hotel_size.times do |i|
        blueprint = {rm_id: "Room ##{i}", cost: COST}
        new_room = Hotel::Room.new(blueprint)
        rooms << new_room
        i + 1
      end
      rooms
    end
  end
end
