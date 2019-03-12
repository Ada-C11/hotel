require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :room, :check_in_date, :check_out_date

    def initialize(reservation_id, room, check_in_date, check_out_date)
      @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)
      raise ArgumentError, "Check_out_date must be after check_in_date" if @check_out_date < @check_in_date
    end
  end
end
