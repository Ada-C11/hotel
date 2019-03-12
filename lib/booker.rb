require_relative "../spec/spec_helper"

module Hotel
  class Booker
    attr_reader :manifest

    def initialize(manifest: Manifest.new)
      @manifest = manifest
    end

    def book_room(range_of_dates, room_id)
      manifest.find_room(id).unavailable << range_of_dates
    end
  end
end
