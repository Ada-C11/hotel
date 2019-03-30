require "date"
require "pry"

require_relative "room"
require_relative "reservation"
require_relative "date_range"

module Hotel
  class Concierge
    attr_reader :all_rooms, :reservations

    def initialize
      @all_rooms = []
      20.times do |i|
        @all_rooms << Hotel::Room.new(room_number: i + 1)
      end
      @reservations = []
    end

    def reserve_room(date_range)
      available_room = @all_rooms.find do |room|
        room.is_available?(date_range)
      end

      reservation = Reservation.new(
        id: @reservations.length + 1,
        room: available_room,
        date_range: date_range,
      )

      @reservations << reservation
      available_room.add_reservation(reservation)
    end

    def view_reservations_by_date(date_range)
      result = @reservations.filter { |res| res.date_range.include_date_range?(date_range) }
      return result
    end

    def view_available_rooms(date_range)
      available_rooms = @all_rooms.select do |room|
        room.is_available?(date_range)
      end

      if available_rooms == []
        raise ArgumentError, "Sorry, no rooms available for the given date range."
      end
      return available_rooms
    end
  end # end Concierge Class
end # end Hotel Module
