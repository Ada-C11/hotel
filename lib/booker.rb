require_relative "../spec/spec_helper"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(range_of_dates, room)
      room.unavailable << range_of_dates.to_a
      room.unavailable.flatten!
      return room
    end
  end
end
