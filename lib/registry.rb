require 'date'
require_relative 'datespans.rb'
module Hotel
  NUM_ROOMS = 20

  class Registry
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
    end

    def res_list
      room = find_room(reservation[:room])
      start_date = Date.parse(reservation[:check_in])
      end_date = Date.parse(reservation[:check_out])
      range = DateSpan.new(start_date, end_date)
      reservation = {
      id: reservation[:id],
      rm_id: rm_id,
      datespan: span
      }
      @reservations << reservation
      return @reservations
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
