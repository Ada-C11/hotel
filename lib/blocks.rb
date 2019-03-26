require "date"

class BlockParty
  attr_reader :blocked_rooms, :total_cost
  ROOM_BLOCK = 5

  def initialize(dates:, blocked_rooms:, discount:)
    # unless id.instance_of?(Integer) && id > 0 && id <= 20
    #   raise ArgumentError, "ID must be a positive number, given #{id}..."
    # end

    @dates = dates
    @blocked_rooms = blocked_rooms
    @discount = discount
  end

  def total_cost
    @discount * (@check_in...@check_out).count
  end
end
