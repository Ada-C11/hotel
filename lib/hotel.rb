require "date"

class Hotel
  attr_reader :reservations

  def initialize
    @room = (1..20).to_a
    @reservations = []
  end

  def list_rooms
    return @room
  end

  def add_reservation(reservation)
    @reservations << reservation
  end

  def list_reservations_by_date(date)
    reservation_by_date = []
    @reservations.each do |reservation|
      if date >= reservation.start_date && date <= reservation.end_date
        reservation_by_date << reservation
      end
    end
    return reservation_by_date
  end
end
