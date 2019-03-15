class Room
  attr_reader :room_id, :reservations
  RATE = 200.freeze
  private_constant :RATE

  def initialize(room_id)
    @room_id = room_id
    @reservations = Array.new
  end

  def reserve(reserved_dates)
    r = Reservation.new(reserved_dates, @room_id, RATE)
    if is_available?(reserved_dates)
      reservations << r
    else
      raise ArgumentError, "The room you want to reserve is not available."
    end
  end

  def is_available?(time_interval)
    @reservations.each do |reservation|
      if reservation.overlap?(time_interval)
        return false
      end
    end
    return true
  end

  def get_reservations_on_date(date)
    list = Array.new
    @reservations.each do |reservation|
      if reservation.has_date?(date)
        list << reservation
      end
    end
    return list
  end
end