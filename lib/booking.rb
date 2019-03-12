# require_relative "room.rb"
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
  end
end
