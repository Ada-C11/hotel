require "Date"

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date, :room_number, :all_dates

    def initialize(check_in_date:, check_out_date:, room_number:)
      @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)
      @all_dates = @check_in_date..@check_out_date
      @room_number = room_number

      raise ArgumentError, "Check-out date cannot be before check-in date" if check_out_date < check_in_date
    end

    def total_cost
      return @check_in_date == check_out_date ? 200.0 : (@check_out_date - @check_in_date) * 200.0
    end
  end
end
