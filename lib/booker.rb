require_relative "manifest"
require_relative "reservation"
require_relative "custom_exceptions"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(reservation, room)
      unless room.available_for_date_range?(date_range: reservation.date_range)
        raise RoomNotAvailable.new("Room #{room.id} not available for requested dates")
      end
      reservation.cost = calculate_cost_of_booking(reservation: reservation, room: room)
      room.unavailable_list << reservation
      return room
    end

    def calculate_cost_of_booking(reservation:, room:, percent_discount: 0)
      return room.cost_per_night.to_f * reservation.duration_in_days * ((100 - percent_discount) / 100)
    end

    def get_cost_of_booking(reservation)
      return reservation.cost
    end
  end
end
