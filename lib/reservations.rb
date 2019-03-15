module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :range, :duration, :total

    def initialize(check_in, duration)
      @check_in = Date.parse(check_in)
      @check_out = (Date.parse(check_in) + duration)
      @range = (@check_in..@check_out)
      @duration = duration
      @total = COST * @duration
    end
  end
end
