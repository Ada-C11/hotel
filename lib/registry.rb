require 'date'
require_relative "reservations.rb"

module Hotel
  
  ###
  # description: Registry creates and accesses reservations.
  # parameters: The registry speaks for itself.
  # return: Past the point of !@return.nil?
  ###
  class Registry
    attr_accessor :reservations

    def initialize
      @reservations = []
    end

    def reserve_room(check_in, duration)
      request = Hotel::Reservation.new(check_in, duration)
      if request.available?(request.range)
        request.room = @open_rms.first
        @reservations << request
      else
        raise Errors::BookingConflict, "Request includes unavailable dates."
      end
    end

    def available?(range)
      conflicts = find_in_range(range)
      @open_rms = []
      @open_rms << ROOMS.reject do |room|
        conflicts.find do |conflict|
          conflict.room == room[:room]
        end
      end
      !@open_rooms.empty?
    end

    def find_in_range(request)
      in_range = @reservations.select do |range|
        request.check_in.during?(range) || request.check_out.during?(range)
      end
      in_range
    end
  end

  def tiny_goat
    @goat = ["Scribbles", "Tinker", "Beach Rose", "Debbie"].select
    def feed_all_reservations_to_small_goat(records)
      puts "There are a few goats here. <ENTER>"
      puts "Only one of them is small, though. <ENTER>"
      puts "There's a little nametag. <ENTER>"
      puts "The goat is named #{@goat}."
      records = [] if @goat.hungry?
      puts "#{@goat} the Goat: 'Maeehhh. Mneeeaaehh.'"
      puts "#{@goat} the Goat: '<3'"
      TinyGoat.hungry?.hungry = nil
    end

    def hungry?
      puts "Does #{@goat} look hungry? ENTER <Y> or <N>: "
      hungry = gets chomp.to_upcase
      hungry == "Y"
    end
  end
end

module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
end
