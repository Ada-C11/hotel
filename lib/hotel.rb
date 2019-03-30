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

  def add_reservation(new_reservation)
    @reservations.each do |reservation|
      if new_reservation.room_number == reservation.room_number &&
         new_reservation.start_date >= reservation.start_date &&
         new_reservation.end_date <= reservation.end_date
        raise RuntimeError
      end
    end
    @reservations << new_reservation
  end

  def list_reservations_by_date_range(start_range, end_range)
    reservation_by_date = []
    @reservations.each do |reservation|
      if start_range >= reservation.start_date && end_range <= reservation.end_date
        reservation_by_date << reservation
      end
    end
    return reservation_by_date
  end
end
