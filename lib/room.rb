module Hotel
  class Room
    attr_accessor :room_num, :room_rate

    def initialize(room_num:, room_rate: 200)
      @room_num = room_num
      @room_rate = room_rate

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