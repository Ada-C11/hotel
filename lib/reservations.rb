require 'date'
require_relative "registry.rb"
require_relative "errors.rb"
COST = 200
module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      raise Errors::ValidationError if check_in.nil? || check_out.nil?
      raise Errors::NotThatKindaHotelPal if check_in == check_out
      raise Errors::ReverseDates if check_in > check_out

      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room = room
    end

    def range
      (check_in..check_out)
    end

    def duration
      (range.count - 1)
    end

    def total
      (COST * duration).to_f
    end
  end
end
