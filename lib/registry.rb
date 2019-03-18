require 'date'
require './spec/spec_helper.rb'
require_relative 'errors.rb'

ROOMS = (1..20).to_a
module Hotel
  class Registry
    attr_accessor :reservations, :okay_rooms, :blocks

    def initialize
      @reservations = []
      @okay_rooms = []
      @blocks = []
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

    def generate_block(check_in, check_out, block_id, quantity)
      if available?(check_in, check_out, block_id)
        block_rooms = okay_rooms[0..quantity]
        block = {rooms: block_rooms, check_in: check_in, check_out: check_out, block_id: block_id}
        @blocks << {block}
      end
    end

    def available?(check_in, check_out = nil, block_id = nil)
      if block_id
        blocked = concurrences(check_in, check_out).map(&:block_id)
        @okay_rooms = blocked
      raise Error::BlockFull if @okay_rooms.length >= 5
      else
        booked = concurrences(check_in, check_out).map(&:room)
        @okay_rooms = ROOMS - booked
      end
      !@okay_rooms.empty?
    end

    def concurrences(date1, date2 = nil, block_id = nil)
      inquery = Date.parse(date1)
      if date2
        outquery = Date.parse(date2)
        concurrences = @reservations.select do |r|
          inquery.between?(r.check_in, r.check_out) || outquery.between?(r.check_in, r.check_out)
        end
      else
        concurrences = @reservations.select do |r|
          inquery.between?(r.check_in, r.check_out)
        end
      end
      concurrences
    end

    def list_available(check_in, check_out = nil)
      available?(check_in, check_out)
      @okay_rooms
    end
  end
end
