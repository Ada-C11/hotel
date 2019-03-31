require_relative "booking.rb"

module Hotel
  class Block < Reservation

    attr_reader :rooms

    def initialize(checkin, checkout, rooms, discounted_rate)
      @checkin = checkin
      @checkout = checkout
      @dates = Hotel::Reservation.reservation_dates(checkin, checkout)
      @rooms = rooms
      @discounted_rate = discounted_rate
    end
  end
end
