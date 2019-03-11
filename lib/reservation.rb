require "date"
require "pry"

class Reservation
  attr_reader :reservation_id
  attr_accessor :check_in, :check_out

  def initialize(reservation_id, check_in: nil, check_out: nil, room: nil)
    @reservation_id = reservation_id
    @check_in = check_in
    @check_out = check_out
    @room = room
  end

  def duration
    if self.check_in != nil && self.check_out != nil
      duration = (Date.parse(check_out) - Date.parse(check_in)).to_i

      if duration <= 0
        raise ArgumentError, "Check out time is not after check in time. Duration is currently #{duration} days."
      end
    else
      return nil
    end
    return duration
  end

  def cost(duration)
    cost_per_room = 200
    reservation_cost = cost_per_room * duration
    return reservation_cost
  end
end
