require "date"

require_relative "room"
require_relative "reservation"

module Hotel
  class FrontDesk
    NUMBER_OF_ROOMS = 20

    attr_reader :rooms, :reservations

    def initialize
      @reservations = []

      rooms_array = []
      NUMBER_OF_ROOMS.times do |i|
        rooms_array << Hotel::Room.new(i + 1)
      end
      @rooms = rooms_array
    end

    def reserve(start_date, end_date, room = nil)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)

      if start_date >= end_date
        raise ArgumentError, "Reservation must be at least one day long."
      end

      room = find_open_room
      new_reservation = Hotel::Reservation.new(start_date, end_date, room)
      @reservations << new_reservation
      return new_reservation
    end

    def find_by_date(date)
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
        else
          raise ArgumentError, "No rooms available"
        end
      end
    end
  end
end
