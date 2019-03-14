require "Date"

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date, :room_number, :all_dates

    def initialize(check_in_date:, check_out_date:, room_number:)
      @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)

      if @check_in_date == @check_out_date
        @all_dates = [@check_in_date]
      else
        @all_dates = (@check_in_date...@check_out_date).to_a
        # map { |date| date }
      end

      @room_number = room_number

      if check_out_date < check_in_date
        raise ArgumentError, "Check-out date cannot be before check-in date"
      end
    end

    def total_cost
      all_dates.length * 200.0
    end
  end
end
