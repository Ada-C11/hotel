require_relative "../spec/spec_helper"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(reservation, room)
      room.unavailable << reservation
      return room
    end
  end
end
