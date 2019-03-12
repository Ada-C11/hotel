require_relative "availability.rb"
require "date"
require_relative "datespans.rb"
module Hotel
  NUM_ROOMS = 20
  ROOM_RATE = 200.00
  class Registry
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..NUM_ROOMS).to_a
      @reservations = []
    end

    def find_by_date(date)
      date = Date.parse(date)
      by_date = @reservations.select do |entry|
        entry.date.find_in_range(date)
      end
      by_date
    end

    def find_in_range(span)
      in_range = @reservations.select do |entry|
        entry.span.overlaps?(span)
      end
      in_range
    end

    def available_rooms(span)
      conflicts = find_in_range(span)
      available_rooms = @rooms.reject do |room|
        conflicts.find do |entry|
          entry.room_number == room[:room_number]
        end
      end
      return available_rooms
    end
  end
end
