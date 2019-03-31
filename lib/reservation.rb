require "date"
require "pry"

class Reservation
  attr_accessor :reservation_id, :check_in, :check_out, :room, :is_hotel_blocker

  def initialize(reservation_id, check_in: nil, check_out: nil, room: nil, is_hotel_blocker: false)
    @reservation_id = reservation_id
    @check_in = check_in == nil ? nil : Date.parse(check_in)
    @check_out = check_out == nil ? nil : Date.parse(check_out)
    @room = all_rooms.sample
    @is_hotel_blocker = is_hotel_blocker
  end

  def duration
    if self.check_in != nil && self.check_out != nil
      duration = (check_out - check_in).to_i

      if duration <= 0
        raise ArgumentError, "Check out time is not after check in time. Inputted check in date was #{check_in} and check out date was #{check_out}"
      end
    else
      return nil
    end
    return duration
  end

  def cost(duration)
    if is_hotel_blocker
      cost_per_room = 150
    else
      cost_per_room = 200
    end

    reservation_cost = cost_per_room * duration
    return reservation_cost
  end

  def all_rooms
    all_rooms = (1..20).map { |i| i }
    return all_rooms
  end
end
