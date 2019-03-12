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
        raise ArgumentError, "Reservation must be at least one day long."
      end

      reservations << Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: find_open_room)

      return reservations.last
    end

    def find_by_date(date:)
      date = Date.parse(date)
      on_this_date = []
      reservations.each do |reservation|
        if reservation.dates.include?(date)
          on_this_date << reservation
        end
      end

      return on_this_date
    end

    def find_open_room
      rooms.each do |room|
        if room.available?
          return room
          break
        end
      end
      raise ArgumentError, "No rooms available"
    end

    private

    def rooms_array
      rooms_array = []
      NUMBER_OF_ROOMS.times do |i|
        rooms_array << Hotel::Room.new(room_number: i + 1)
      end
      return rooms_array
    end
  end
end
