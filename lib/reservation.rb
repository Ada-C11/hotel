require_relative 'date_range'
require_relative 'room'

class Reservation
  RATE = 200
  attr_accessor :date_range, :cost_of_stay, :room

  def initialize(check_in:, check_out:, room:)
    @room = room
    @date_range = DateRange.generate_date_range(check_in, check_out)
    @cost_of_stay = RATE * (date_range.length)
  end
end

# n = Reservation.new(check_in: '2019-04-01', check_out: '2019-04-02', room: 1)
# puts n.room