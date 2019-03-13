HOTEL_SIZE = 20
COST = 200.00
module Hotel

  class Room
    attr_reader :rm_id, :cost

    def initialize(input)
      rm_id = input[:rm_id]
      cost = input[:cost]
    end
  end

  private

  class Hotel

    def room_template
      blueprint = {
        rm_id: "Room #" + "#{i}"
        :cost =  COST
      }
    end

    def build_new_rooms(input)
      input.times do |i|
      new_room = Room.new(Hotel.room_template)
      rooms << new_room
      i += 1
    end
  end
end
