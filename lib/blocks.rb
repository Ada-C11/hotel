require_relative "date_range"

class BlockParty < DateRange
  attr_reader :blocked_rooms, :total_cost
  ROOM_BLOCK = 5

  def initialize(rooms, check_in, check_out, rate)
    if rooms.empty?
      raise ArgumentError, "Cannot create an empty block reservation..."
    end

    super(check_in, check_out)
    @rooms = rooms
    @available_rooms = rooms.dup
    @rate = rate
    @blocked_rooms = []
  end
end
