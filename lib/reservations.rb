require 'date'
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
      @duration = duration.to_i
      @check_out = Date.parse(check_in) + @duration
      @range = (@check_in..@check_out)
      @total = COST * @duration
      @room = room
    end

    def available?(range)
      conflicts = find_in_range(@request.range)
      @open_rms = []
      @open_rms << ROOMS.reject do |room|
        conflicts.find do |conflict|
          conflict.room == room[:room]
        end
      end
      !@open_rooms.empty?
    end

    def find_in_range(range)
      in_range = @reservations.range.select do |range|
        @request.check_in.during?(range) || @request.check_out.during?(range)
      end
      in_range
    end
  end
end
