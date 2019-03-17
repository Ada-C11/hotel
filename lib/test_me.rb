require "date"

class BlockParty
  attr_reader :id, :price, :block_rooms, :booked_on
  ROOM_BLOCK = 5

  def initialize(id:, block_rooms: nil)
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

  def room_available?(check_in:, check_out:)
    @bookings.each do |booked|
      if booked == nil
        return true
      end
      if (check_in..check_out).include?(booked)
        return false
      end
      if check_out == booked.first || check_in == booked.last
        return true
      elsif booked.include?(check_in) || booked.include?(check_out) || check_in <= booked.first && check_out >= booked.last
        return false
      end
    end
    return true
  end
end

