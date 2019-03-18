

require_relative "reservation"
require_relative "room"

class Manager
  attr_reader :reservations, :rooms, :bookings, :cost

  def initialize
    @reservations = []
    @rooms = rooms
    @cost = 200
  end

  # def bookings(check_in, check_out)
  #   @reservations << Reservation.new(check_in, check_out, @rooms)
  # end

  # doesn't work yet
  # def find_reservation(id)
  #   Reservation.validate_id(id)
  #   return @reservations.find { |reservation| reservation.id == id }
  # end
  def all_reservations
    @reservations << book_reservation(rooms)
  end

  def make_rooms
    @rooms = (1..20).to_a.map! do |room|
      Room.new(id: room)
    end
  end

  # has a find method for each class
  # total cost for given reservation
  # raises exceptions for invalid date ranges

end
