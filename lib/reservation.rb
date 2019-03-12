# Require gems
require "date"

# Require relatives
require_relative "room.rb"

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room_number, :total_cost, :id

    def initialize(check_in:, check_out:, room_number: nil, total_cost: nil, id: rand(10 ** 3))
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room_number = room_number
      @total_cost = total_cost
      @id = id

      if @check_in >= @check_out
        raise ArgumentError, "Invalid date range #{@check_in}, #{@check_out}"
      end
    end
  end
end
