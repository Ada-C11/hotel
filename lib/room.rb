module Hotel
  class Room
    attr_reader :room_id, :reservations

    def initialize(room_id)
      @room_id = room_id
      @reservations = []
    end
  end
end
