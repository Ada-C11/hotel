require 'date'
require './spec/spec_helper.rb'
require 'pry'
ROOMS = (1..20).to_a
module Hotel
  class Registry
    attr_accessor :reservations, :okay_rooms

    def initialize
      @reservations = []
      @okay_rooms = []
    end

    def book_room(check_in, check_out)
      if available?(check_in, check_out)
        certainly_our_finest_room = okay_rooms.first
        @reservations << Hotel::Reservation.new(check_in, check_out, certainly_our_finest_room)
        @reservations
      else
        raise Errors::BookingConflict
      end
    end

    def available?(check_in, check_out)
      booked = concurrences(check_in, check_out).map(&:room)
      @okay_rooms = ROOMS - booked
      !@okay_rooms.empty?
    end

    def concurrences(date1, date2 = nil)
      if date2
        inquery = Date.parse(date1)
        outquery = Date.parse(date2)
        concurrences = @reservations.select do |res|
          inquery.between?(res.check_in, res.check_out) || outquery.between?(res.check_in, res.check_out)
        end
      elsif
        inquery = Date.parse(date1)
        concurrences = @reservations.select do |res|
          res.range.include?(inquery)
        end
      end
      concurrences
    end
  end
end

module Errors
  class BookingConflict < StandardError; end
  class ValidationError < StandardError; end
  class ReverseDates < StandardError; end
  class NotThatKindofHotelPal < StandardError; end
end
