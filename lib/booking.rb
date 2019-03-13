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
      date_range = Reservation.reservation_dates(checkin, checkout)
      room = check_availability(date_range)
      num_nights = Reservation.nights(checkin, checkout)
      reservation = Hotel::Reservation.new(checkin: checkin, checkout: checkout, nights: num_nights, dates: date_range, room: room)
      @reservations << reservation
      return reservation
    end

    def check_availability(date_range)
      return @rooms.first 
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