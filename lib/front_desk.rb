require "date"

require_relative "room"
require_relative "reservation"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations

    def initialize
      @reservations = []

      @rooms = rooms_array
    end

    def reserve(start_date:, end_date:)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)

      if start_date >= end_date
        raise ArgumentError, "Reservation must be at least one day long"
      end

      reservations << Hotel::Reservation.new(start_date: start_date,
                                             end_date: end_date,
                                             room: find_open_room)

      return reservations.last
    end

    def find_by_date(date:)
      date = Date.parse(date)
      on_this_date = []

      reservations.select { |reservation| reservation.dates.include?(date) }
    end

    def find_open_room
      open_room = rooms.find { |room| room.available? }
      raise ArgumentError, "No rooms available" unless open_room
      return open_room
    end

    private

    def rooms_array
      rooms = []
      NUMBER_OF_ROOMS.times { |i| rooms << Hotel::Room.new(room_number: i + 1) }
      return rooms
    end
  end
end
