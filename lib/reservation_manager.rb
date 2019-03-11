require_relative "reservation"

class Reservation_manager
  def initialize
    @check_in_time = check_in_time
    @check_out_time = check_out_time
  end
end
