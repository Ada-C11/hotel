require_relative "Reservation"

class Hotel
  attr_reader :reservations, :rooms

  def initialize
    @reservations = []
    @rooms = (1..20).to_a
  end

  def make_reservation(check_in:, check_out:, room: nil)
    if room == nil
      room = available_rooms(check_in: check_in, check_out: check_out).first
    end
    reservation = Reservation.new(check_in: check_in, check_out: check_out, room: room)
    @reservations << reservation
    #add argument error if there is a booking already at that day

  end

  def list_rooms()
    return @rooms
  end

  def reservation_by_date(date)
    raise ArgumentError, "must pass in a Date object" if date.instance_of?(Date) == false
    res_by_date = @reservations.select do |x|
      x.check_in <= date && date < x.check_out
    end
  end

  def available_rooms(check_in:, check_out:)
    dates = (check_in..check_out - 1).to_a
    booked_rooms = []
    dates.each do |date|
      reservation_by_date(date).each do |res|
        booked_rooms << res.room
      end
    end
    available_rooms = (@rooms - booked_rooms)
    return available_rooms
  end

  def reserve_available_room(check_in:, check_out:)
    available = available_rooms(check_in: check_in, check_out: check_out)
    raise ArgumentError, "no available rooms" if available == nil
    make_reservation(check_in: check_in, check_out: check_out, room: available.first)
  end
end
