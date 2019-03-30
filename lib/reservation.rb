# Require gems
require "date"

# Require relatives
require_relative "room.rb"

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room, :total_cost, :id

    def initialize(check_in:, check_out:, room:, total_cost: nil, id: nil)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room = room
      @total_cost = total_cost(check_in, check_out, room.cost_per_night)
      @id = id

      validate_date
    end

    def total_cost(check_in, check_out, cost_per_night)
      number_of_nights = number_of_nights(check_in, check_out)
      total_cost = cost_per_night * number_of_nights

      return total_cost
    end

    def number_of_nights(check_in, check_out)
      number_of_nights = 0
      (check_in...check_out).each do
        number_of_nights += 1
      end
      return number_of_nights
    end

    def validate_date
      format = /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
      if @check_in >= @check_out
        raise ArgumentError, "Invalid date range #{@check_in}, #{@check_out}"
      elsif !(@check_in.to_s =~ format) || !(@check_out.to_s =~ format)
        raise ArgumentError, "Invalid date format #{check_in}, #{check_out}.  Must be YYYY-MM-DD"
      elsif @check_in < Date.today
        raise ArgumentError, "Can't make a reservation for the past, homie. #{check_in}"
      end
    end

    def self.new_reservation(check_in, check_out, available_room, id)
      reservation = Reservation.new(
        check_in: check_in,
        check_out: check_out,
        room: available_room,
        id: id,
      )
    end
  end
end
