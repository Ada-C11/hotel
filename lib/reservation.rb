require "date"
require "pry"

class Reservation
  attr_reader :reservation_id
  attr_accessor :check_in, :check_out, :room

  def initialize(reservation_id, check_in: nil, check_out: nil, room: nil)
    @reservation_id = reservation_id

    if check_in == nil
      @check_in = nil
    else
      @check_in = Date.parse(check_in)
    end

    if check_out == nil
      @check_out = nil
    else
      @check_out = Date.parse(check_out)
    end
    #assign random room for wave 1
    @room = all_rooms.sample
    # @available_rooms = (1..20).map { |i| i }
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
    cost_per_room = 200
    reservation_cost = cost_per_room * duration
    return reservation_cost
  end

  def all_rooms
    all_rooms = []
    20.times do |i|
      all_rooms << i + 1
    end
    return all_rooms
  end
end
