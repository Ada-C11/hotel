module Hotel
  COST = 200
  ROOMS = (1..20).to_a.freeze
  class Registry
    attr_accessor :reservations

    def initialize
      @reservations = []
    end

    def reserve_room(check_in, duration)
      request = Reservation.new(check_in, duration)
      if request.available?(@check_in, @check_out)
        request.room = @open_rms.first
        @reservations << request
      else
        raise Errors::BookingConflict, "Request includes unavailable dates."
      end
    end

    private

    @open_rms = []

    def available?(date_range)
      @open_rms << ROOMS.reject do |room|
        conflicts = find_in_range(date_range)
        conflicts.find do |conflict|
          conflict.room == room[:room]
        end
      end
      !@open_rooms.empty?
    end

    def find_in_range(request)
      in_range = @reservations.range.select do |range|
        request.check_in.during?(range) || request.check_out.during?(range)
      end
      in_range
    end

#     def find_by_date(date)
#       date = Date.parse(date)
#       by_date = @reservations.select do |entry|
#         entry.date.find_in_range(date)
#       end
#       by_date
#     end
#   end
# end

module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
end
