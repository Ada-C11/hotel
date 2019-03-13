require "pry"
require "date"

module Hotel
  class Reservation
    attr_reader :reservation_id, :room, :room_id, :check_in_date, :check_out_date

    def initialize(reservation_id:, room: nil, room_id: nil, check_in_date:, check_out_date:)
      if room
        @room = room
        @room_id = room.room_id
      elsif room_id
        @room_id = room_id
      else
        raise ArgumentError, "room or room_id is required"
      end

      @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)
      raise ArgumentError, "Check_out_date must be after check_in_date" if @check_out_date < @check_in_date || @check_in_date == nil || @check_out_date == nil
    end

    def cost
      num_nights = @check_out_date - @check_in_date
      return 200.0 * num_nights
    end

    def self.load_all
      @reservations = []
    end

    def connect(room)
      @room = room
      room.add_reservation(self)
    end
  end
end
