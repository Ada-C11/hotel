require "date"
require_relative "reservation.rb"

module Hotel
  class Booking
    attr_accessor :rooms, :reservations
    def initialize
      @rooms = []
      @reservations = []
    end

    def request_reservation(checkin, checkout)
      Reservation.validate_dates(checkin, checkout)
      date_range = Reservation.reservation_dates(checkin, checkout)
      room = check_availability(date_range).first
      reservation = Hotel::Reservation.new(checkin: checkin, checkout: checkout, room: room)
      @reservations << reservation
      room.add_reservation(reservation)
      return reservation
    end

    def check_availability(date_range)
      date_range.pop
      taken_rooms = []
      date_range.each do |date|
        res_list = find_reservation(date)
        res_list.each do |res|
          taken_rooms << res.room.id
        end
      end
      taken_rooms = taken_rooms.uniq.sort!

      avail_rooms = @rooms.reject do |room|
        taken_rooms.include? room.id
      end

      if avail_rooms.empty?
        raise ArgumentError, 'No rooms are available for those dates'
      end
      return avail_rooms
    end

    def find_reservation(date)
      return @reservations.select { |res| res.includes_date?(date) }
    end
  end
end