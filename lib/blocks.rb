require "date"

class BlockParty
  attr_reader :id, :price, :block_rooms, :booked_on
  ROOM_BLOCK = 5

  def initialize(id:, block_reservation: nil)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end

    @id = id
    @block_rooms = []
  end

  def self.blocked_rooms
    block_rooms = []
  end

  def booked_on(check_in:, check_out:)
    @bookings << (Date.parse(check_in)..Date.parse(check_out))
  end
end

