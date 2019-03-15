module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :range, :duration, :total, :room

    def initialize(check_in, duration, room = nil)
      @check_in = Date.parse(check_in)
      @check_out = (Date.parse(check_in) + duration)
      @range = (@check_in..@check_out)
      @duration = duration
      @total = COST * @duration
      @room = room
    end
  end
end
