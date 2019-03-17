module Hotel
  class Room
    attr_accessor :room_num, :status, :room_rate

    def initialize(room_num:, room_rate: 200, status: :AVAILABLE)
      @room_num = room_num
      @room_rate = room_rate
      @status = status

      raise ArgumentError.new("Invalid room number") if @room_num < 1 || @room_num > 20
    end

    def self.list_all_rooms
      rooms = []
      20.times do |i|
        room = Hotel::Room.new(room_num: i+1)
        rooms << room
      end
      return rooms
    end
  end
end