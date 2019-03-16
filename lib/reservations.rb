require 'date'
require_relative "registry.rb"
COST = 200
ROOMS = (1..20).to_a
module Hotel
  ###
  # description: Reservations contains a constructor for reservations.
  # parameters: check_in, duration, room is optional ... makes everything else.
  # return: Hopefully an instance of Reservation.
  ###
  class Reservation
    attr_reader :check_in, :check_out, :range, :duration, :total, :room

    def initialize(check_in, check_out, room = nil)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @range = (@check_in..@check_out)
      @duration = @range.count
      @total = COST * @duration
      @room = room
    end

    # def available?(range)
    #   conflicts = find_in_range(@request)
    #   @open_rooms = []
    #   @open_rooms << ROOMS.reject do |room|
    #     conflicts.find do |conflict|
    #       conflict.room == room[:room]
    #     end
    #   end
    #   !@open_rooms.empty?
    # end

    # def find_in_range(range)
    #   in_range = @@reservations.range.select do |booking|
    #     @request.check_in.during?(booking) || @request.check_out.during?(booking)
    #   end
    #   in_range
    # end
  end
end
