require "date"

class Room
  attr_reader :id, :price, :bookings, :booked_on

  def initialize(id)
    unless id.instance_of?(Integer) && id > 0 && id <= 20
      raise ArgumentError, "ID must be a positive number, given #{id}..."
    end

    @id = id
    @bookings = []
  end

  def booked_on(reservation_span)
    @bookings << reservation_span #will have a range of it's own bookings
  end

  def room_available?(check_in, check_out)
    # if no bookings write a test for it!
    @bookings.each do |booked|
      if check_out == booked.to_a[0]
        return true
      elsif booked.include?(check_out) || booked.include?(check_in)
        return false
      end
    end
    return true
  end 
end

