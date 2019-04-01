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
        unless room.available_for_block?(checkin, checkout)
          raise BlockBookingError, 'Cannot reserve block, one or more rooms are unavailable'
        end
      end
      @rooms = rooms
      @discounted_rate = discounted_rate
    end

    def rooms_available
      avail_rooms = []
      @rooms.each do |room|
        if room.available_for_res?(@checkin, @checkout)
          avail_rooms << room
        end
      end
      return avail_rooms
    end
  end
end