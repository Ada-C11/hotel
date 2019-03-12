require_relative "availability.rb"
require "date"
require_relative "datespans.rb"
module Hotel
  NUM_ROOMS = 20
  ROOM_RATE = 200.00
  class BookingManager
    attr_reader :rooms, :reservations

    def initialize
      @rooms = []
      @reservations = []
    end

    def make_reservation(check_in, check_out)
      available_rooms = list_available_rooms(Hotel::DateSpan.new(check_in, check_out))
      if available_rooms.empty?
        raise StandardError, "No rooms are available in that range"
      end
      room_number = available_rooms.shift
      reservation = Hotel::Reservation.new(room_number, ROOM_RATE, check_in, check_out)
      @reservations << reservation
      return reservation
    end

    def reservations_by_date(date)
      date = Date.parse(date)
      res_by_date = @reservations.select do |res|
        res.date_range.included_in_date_range(date)
      end
      return res_by_date
    end

    def reservations_by_date_range(date_range)
      res_by_date_range = @reservations.select do |res|
        res.date_range.overlaps?(date_range)
      end
      return res_by_date_range
    end
  end
end