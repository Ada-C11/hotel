module HotelSystem
  class Hotel
    attr_reader :reservations, :blocks
    attr_accessor :rooms

    def initialize(id:, rooms: [], reservations: [], blocks: [])
      @id = id
      @rooms = rooms
      @reservations = reservations
      @blocks = blocks
    end

    def list_rooms
      room_list = @rooms.map { |room| room.id }
      return nil if rooms.length == 0
      return room_list
    end
  end
end
