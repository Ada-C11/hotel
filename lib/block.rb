require_relative "booking.rb"

module Hotel
  class Block < Reservation
    class BlockBookingError < StandardError; end

    attr_reader :rooms

    def initialize(checkin, checkout, rooms, discounted_rate)
      @checkin = checkin
      @checkout = checkout
      @dates = Hotel::Reservation.reservation_dates(checkin, checkout)
      rooms.each do |room|
        unless room.is_available?(checkin, checkout)
          raise BlockBookingError, 'Cannot reserve block, one or more rooms are unavailable'
        end
      end
      @rooms = rooms
      @discounted_rate = discounted_rate
    end
  end
end
