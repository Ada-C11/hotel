# Require gems

# Require relatives
require_relative "room.rb"
require_relative "reservation.rb"

module Hotel
  class Manager
    attr_reader :rooms

    def initialize
      @rooms = (1..20).map do |room_number|
        Hotel::Room.new(room_number: room_number)
      end
    end

    def make_reservation(check_in, check_out)
      reservation = Hotel::Reservation.new(
        check_in: check_in,
        check_out: check_out,
      )

      return reservation
    end
  end
end
