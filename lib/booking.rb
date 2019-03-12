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
      reservation = Hotel::Reservation.new(checkin, checkout)
      reservations << reservation
      return reservation
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