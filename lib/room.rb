require "date"

class Room
  attr_reader :id, :price, :bookings, :booked_on
  ROOMS = 20

  def initialize(id:, bookings: nil)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end

    @id = id
    @bookings ||= []
  end

  def self.hotel_rooms
    rooms = []
    ROOMS.times do |room_num|
      rooms << Room.new(id: room_num + 1)
    end
    return rooms
  end

  def booked_on(check_in:, check_out:)
    @bookings << (Date.parse(check_in)..Date.parse(check_out))
  end

  def room_available?(check_in:, check_out:)
    check_in = Date.parse(check_in)
    check_out = Date.parse(check_out)
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
