HOTEL_SIZE = 20
COST = 200.00
module Hotel

  class Room
    attr_reader :rm_id, :cost

    def initialize(input)
      rm_id = input[:room_id]
      cost = input[:cost]
    end
  end

  private

  class Hotel
    def room_template
      blueprint = 
    end

    def build_new_hotel(blueprint)
      HOTEL_SIZE.times do |blueprint|
      room = Room.new(blueprint)
      rooms << room
    end
  end
end
