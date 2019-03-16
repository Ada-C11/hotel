require 'date'
require_relative "registry.rb"
COST = 200
module Hotel
  ###
  # description: Reservations contains a constructor for reservations.
  # parameters: check_in, duration, room is optional ... makes everything else.
  # return: Hopefully an instance of Reservation.
  ###
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room = room
    end

    def range
      (check_in..check_out)
    end

    def duration
      range.count
    end

    def total
      COST * duration
    end
  end
end
