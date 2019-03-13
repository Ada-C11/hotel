require_relative "../spec/spec_helper"

module Hotel
  class Booker
    SALES_TAX_ADJUSTMENT = 1.09
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(reservation, room)
      room.unavailable_list << reservation
      return room
    end

    def total_cost_of_booking(reservation, room)
      return room.cost_per_night * reservation.duration * SALES_TAX_ADJUSTMENT
    end

    def room_base_cost
      return room.cost_per_night
    end

    def length_of_stay(reservation)
      return reservation.duration
    end
  end
end
