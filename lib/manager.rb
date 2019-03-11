# Require gems
require "date"

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
      available_room = @rooms.sample

      reservation = Hotel::Reservation.new(
        check_in: check_in,
        check_out: check_out,
        room_number: available_room.room_number,
      )

      available_room.reservations << reservation

      return reservation
    end

    def list_reservations(date)
      list = []
      date = Date.parse(date)

      @rooms.each do |room|
        room.reservations.each do |reservation|
          check_in = reservation.check_in
          check_out = reservation.check_out

          if (check_in..check_out).include?(date)
            list << reservation
          end
        end
      end
      return list
    end
  end
end
