class Reservation
  attr_reader :check_in_date, :check_out_date, :room_number

  def initialize(check_in_date:, check_out_date:, room_number:)
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @room_number = room_number
  end
end
