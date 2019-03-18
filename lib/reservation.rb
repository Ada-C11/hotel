

class Reservation
  attr_reader :check_in, :check_out, :room

  def initialize(check_in:, check_out:, rooms:)
    @check_in = Date.parse(check_in)

    @check_out = Date.parse(check_out)
    if !@check_out.nil? && @check_out < @check_in
      raise ArgumentError.new("Check-out date before check-in date")
    end
    @room = book_reservation(rooms)
  end

  # or by date since date is set when the reservation is booked.

  # redesign, look at the number of nights insead of check-in, check-out
  # compare number of nights for overlap
  def book_reservation(rooms)
    # to-do: make sure you find the room corelating** to the room_id
    available_room = rooms.find_index do |room|
      next if !room.dates.empty?
    else
      return room  #compare dates or choose empty? room
    end
    # # take the first available room and assign it.
    # # add to the bookings array.
    return available_room
  end

  def total_cost
    duration = (check_out - check_in).to_i
    total_cost = duration * 200
    return total_cost
  end
end
