require_relative "room"
require_relative "reservation"

module Hotel
  class Hotel_ledger
    attr_reader :all_rooms

    def initialize
      @all_rooms = [*(1..20)]
      @reservations = []
      # @all_rooms.map! do |number|
      #   Room.new(number)
      # end
      # @phone_number = phone_number
      # @in_date = in_date
      # @out_date = out_date
    end

    def list_all_rooms
      return @all_rooms
    end

    def list_all_reservations
      return @reservations
    end

    def make_reservation(phone_number, in_date, out_date)
      reservation = Hotel::Reservation.new(
        phone_number: phone_number,
        in_date: in_date,
        out_date: out_date,
      )
      return reservation
    end

    def find_available_room(in_date, out_date)
      return room
    end

    #   @reservations = Reservation.list_all(date)
    #   @reservation_blocks = Reservation_block.list_all(date)
    # end

    # def available?(range_of_date)
    #   date = Date.parse(range_of_date)
    #   return # room is available ? true : false
    # end
    #   end
  end
end
