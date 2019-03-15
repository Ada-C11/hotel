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
  end
end
module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
end

module TinyGoat
  def hungry?(_goat)
    puts "Does Scribbles look hungry? ENTER <Y> or <N>: "
    hungry = gets chomp.to_upcase
    hungry == "Y"
  end

  def feed_all_reservations_to_small_goat
    puts "There are a few goats here. <ENTER>"
    puts "Only one of them is small, though. <ENTER>"
    puts "There's a little nametag. <ENTER>"
    puts "The goat is named Scribbles."
    @reservations = [] if goat.hungry?
    puts "Scribbles the Goat: 'Maeehhh. Mneeeaaehh.'"
  end
end
