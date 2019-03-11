require "date"
require "pry"

class Reservation
  attr_reader :reservation_id
  attr_accessor :check_in, :check_out

  def initialize(reservation_id, check_in: nil, check_out: nil)
    @reservation_id = reservation_id
    @check_in = check_in
    @check_out = check_out
  end

  def duration
    if self.check_in != nil && self.check_out != nil
      duration = (Date.parse(check_out) - Date.parse(check_in)).to_i
      if duration <= 0
        raise ArgumentError, "Check out time is not after check in time. Duration is currently #{duration} days."
      end
      #   binding.pry
    else
      return nil
    end
    return duration
    #check validity
    # if duration <= 0
    #   raise ArguementError, "Check out time is not after check in time. Duration is currently #{duration} days."
    # end
  end

  def cost
  end
end
