class Room
  attr_reader :room_id, :room_price, :total_room

  def initialize(room_id:)
    @room_id = room_id
    @room_price = 200
  end
end
