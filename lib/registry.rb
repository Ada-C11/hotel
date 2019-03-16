require 'date'
require './spec/spec_helper.rb'

module Hotel
  ###
  # description: Registry creates and accesses reservations.
  # parameters: The registry speaks for itself.
  # return: Past the point of !@return.nil?
  ###
  class Registry
    attr_accessor :reservations, :okay_rooms

    def initialize
      @reservations = []
    end

    def available?(check_in, check_out)
      other_folks = concurrences(check_in, check_out)
      @okay_rooms = []
      @okay_rooms << ROOMS.reject do |room|
        other_folks.find do |booked|
          booked[:room] == room[:room]
        end
      end
      !okay_rooms.empty?
    end

    def concurrences(check_in, check_out)
      concurrences = @reservations.select do |res|
        check_in.between?(res.range) || check_out.between?(res.range)
      end
      concurrences
    end

    def book_room(check_in, check_out)
       if available?(check_in, check_out)
      certainly_our_finest_room = okay_rooms.first
      @reservations << Hotel::Reservation.new(check_in, check_out, certainly_our_finest_room)
      @reservations
       else
        raise Errors::BookingConflict
    end

    def feed_all_reservations_to_small_goat
      goat = ["Scribbles", "Tinker", "Beach Rose", "Deb"].shuffle.first
      puts "There are a few goats here."
      puts "Only one of them is small, though."
      puts "The goat is named #{goat}."
      print "Does #{goat} look hungry? ENTER <Y> or <N>: "
      hungry = gets.chomp.to_upcase
      @reservations.clear if hungry == "Y"
      puts "#{goat} the Goat: 'Maeehhh. Mneeeaaehh.'"
      puts "#{goat} the Goat: '<3'"
    end
  end
end

module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
end
