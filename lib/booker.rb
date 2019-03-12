require_relative "../spec/spec_helper"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(range_of_dates, room)
      room.unavailable << {ReservationDate.confirmation_number => range_of_dates.to_a}
      return room
    end
  end
end
