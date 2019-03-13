require_relative "Reservation"

class Hotel
  ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  def initialize
    @reservations = []
  end

  def make_reservation(check_in:, check_out:)
    reservation = Reservation.new(check_in, check_out)
    @reservations << reservation
  end

  def list_rooms()
    return ROOMS
  end

  def reservation_by_date(date)
    # raise ArgumentError, "invalid date" if
    # need to fix that
    res_by_date = @reservation.select do |x|
      x.check_in <= date && date < x.check_out
    end
  end
end
