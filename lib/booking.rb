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
      num_nights = Reservation.nights(checkin, checkout)
      reservation = Hotel::Reservation.new(checkin: checkin, checkout: checkout, nights: num_nights, dates: date_range, room: room)
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
      avail_rooms = []
      @rooms.each do |room|
        if (taken_rooms.include? room.id) == false
          avail_rooms << room
        end
      end
      return avail_rooms
    end

    def find_reservation(date)
      res_by_date = []
      date = (Date.parse(date)).to_s
      @reservations.each do |res|
        if res.dates.any? date
          res_by_date << res
        end
      end
      return res_by_date
    end
  end
end