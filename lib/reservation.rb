require_relative "room"

class Reservation
  attr_reader :room_num, :check_in, :check_out, :rate, :rooms

  def initialize(room_num:, check_in:, check_out:, rooms:)
    @room_num = available_room(rooms)
    @rate = 200
    @check_in = Date.parse(check_in)

    @check_out = Date.parse(check_out)
    if !@check_out.nil? && @check_out < @check_in
      raise ArgumentError.new("Check-out date before check-in date")
    end
  end

  def available_room(rooms)
    vacant_room = rooms.find_index do |room|
      next if !room.dates.empty?
    else
      return room  #compare dates or choose empty? room
    end
    # # take the first available room and assign it.
    # # add to the bookings array.
    return vacant_room
  end

  def book_reservation(vacant_room, check_in, check_out)
  end

  def total_cost
    duration = (check_out - check_in).to_i
    total_cost = duration * @rate
    return total_cost
  end
end

# class Reservation
#   attr_reader :check_in, :check_out, :room, :reservations

#   def initialize(check_in:, check_out:, rooms:)
#     @check_in = Date.parse(check_in)

#     @check_out = Date.parse(check_out)
#     if !@check_out.nil? && @check_out < @check_in
#       raise ArgumentError.new("Check-out date before check-in date")
#     end
#     @room = book_reservation(rooms)
#     @reservations = []
#   end

#   # or by date since date is set when the reservation is booked.
#   # compare number of nights for overlap
#   def book_reservation(rooms)
#     # checks for available room
#     available_room = rooms.find_index do |room|
#       next if !room.dates.empty?
#     else
#       return room  #compare dates or choose empty? room
#     end
#     # # take the first available room and assign it.
#     # # add to the bookings array.
#     return available_room
#   end

#   def reservation(available_room, check_in, check_out)
#     reservation = Reservation.new(check_in, check_out, rooms)
#   end

#   def all_reservations
#     @reservations << book_reservation(rooms)
#   end

# end
