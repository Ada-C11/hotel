require 'registry.rb'
module Hotel
  ###
  # description: Reservations contains a constructor for reservations.
  # parameters: check_in, duration, room is optional ... makes everything else.
  # return: Hopefully an instance of Reservation.
  ###
  class Reservation
    attr_reader :check_in, :check_out, :range, :duration, :total
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
