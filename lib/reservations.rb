module Hotel
  class Reservation
    attr_reader :total, :check_in, :duration

    def initialize(check_in, duration)
      @date_range = DateRanges.new(check_in) + (check_in + @duration)
      @check_in = check_in
      @duration = duration
      @total = COST * @duration
    end
  end
end
