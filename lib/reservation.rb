# Require gems
require "date"

# Require relatives
require_relative "room.rb"

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room, :total_cost, :id

    def total_cost(check_in, check_out, cost_per_night)
      number_of_nights = 0
      total_cost = 0

      (check_in...check_out).each do
        number_of_nights += 1
      end

      total_cost = cost_per_night * number_of_nights
      return total_cost
    end

    def initialize(check_in:, check_out:, room:, total_cost: nil, id: rand(10 ** 3))
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room = room
      @total_cost = total_cost(check_in, check_out, room.cost_per_night)
      @id = id

      if @check_in >= @check_out
        raise ArgumentError, "Invalid date range #{@check_in}, #{@check_out}"
      end
    end
  end
end
