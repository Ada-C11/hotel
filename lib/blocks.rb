require "date"

class BlockParty
  attr_reader :blocked_rooms, :total_cost
  ROOM_BLOCK = 5

  def initialize(check_in:, check_out:, blocked_rooms:, discount:)
    # unless id.instance_of?(Integer) && id > 0 && id <= 20
    #   raise ArgumentError, "ID must be a positive number, given #{id}..."
    # end

    @check_in = check_in
    @check_out = check_out
    @blocked_rooms = blocked_rooms
    @discount = discount
  end

  def total_cost
    discount * (@check_in...check_out)
  end
end
