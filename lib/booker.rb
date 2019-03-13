require_relative "../spec/spec_helper"

module Hotel
  class Booker
    SALES_TAX_ADJUSTMENT = 1.09
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(reservation, room)
      room.unavailable << reservation
      return room
    end

    def total_cost_of_booking(reservation, room)
      return room.cost_per_day * reservation.duration * SALES_TAX_ADJUSTMENT
    end
  end
end
