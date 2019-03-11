module HotelSystem
  class Hotel
    attr_reader :rooms, :reservations, :blocks

    def initialize(id:, rooms: [], reservations: [], blocks: [])
      @id = id
      @rooms = rooms
      @reservations = reservations
      @blocks = blocks
    end
  end
end
