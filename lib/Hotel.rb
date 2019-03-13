require_relative "Reservation"

class Hotel
  attr_reader :reservations
  ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  def initialize
    @reservations = []
  end

  #blergh, how do I store a room

  def make_reservation(check_in:, check_out:)
    #guess I best be adding rooms
    reservation = Reservation.new(check_in: check_in, check_out: check_out)
    @reservations << reservation
  end

  def list_rooms()
    return ROOMS
  end

  def reservation_by_date(date)
    # raise ArgumentError, "invalid date" if
    # need to fix that
    res_by_date = @reservations.select do |x|
      x.check_in <= date && date <= x.check_out
      #it keeps check out as part of the resrvation, remember not to use this for adding a resrevation, or be aware last day is taken
    end
    #so its nil if its empty, but is that a valid response?
  end

  def available_rooms(check_in:, check_out:)
    #see all available rooms for that date range

  end
end
