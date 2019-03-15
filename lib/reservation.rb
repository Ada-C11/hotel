
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

  # then book the reservation by room id and store it in the bookings array.
  # the manager will keep track of bookings.
  # the manager should have methods where you can find the reservation bu booling id
  # or by date since date is set when the reservation is booked.

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

  def duration
    (check_out - check_in).to_i
  end

  def total_cost
    total_cost = (check_out - check_in).to_i * 200
    return duration
  end
end
