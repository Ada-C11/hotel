require "Date"

class Reservation
  attr_reader :check_in_date, :check_out_date, :room_number, :all_dates

  def initialize(check_in_date:, check_out_date:, room_number:)
    @check_in_date = Date.strptime(check_in_date)
    @check_out_date = Date.strptime(check_out_date)
    @all_dates = @check_in_date..@check_out_date
    @room_number = room_number

    raise ArgumentError, "Check-out date cannot be before check-in date" if check_out_date < check_in_date
  end
end
