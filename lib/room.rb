module Hotel
  class Room

    STATUS = [:AVAILABLE, :UNAVAILABLE]

    attr_reader :id, :room_num, :cost
    attr_accessor :status, :available_rooms, :unavailable_rooms

    def initialize(id:, room_num:, status: :AVAILABLE, cost: 200)
      @id = id
      @room_num = room_num
      @status = :AVAILABLE.to_sym
      @cost = cost
      @available_rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
      @unavailable_rooms = []
    end
  end
end