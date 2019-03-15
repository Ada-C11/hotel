require "datespans.rb"

module Hotel
  class Reservation
    attr_reader :total, :check_in, :duration

    def initialize(check_in, duration)
      @date_range = DateRanges.new(check_in) + @duration
      @duration = duration
      @total = COST * @duration
    end
  end
end
