require "pry"
require "date"
require_relative "room_manager"

module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date, :room, :room_id, :reservation_id

    def initialize(check_in_date:, check_out_date:, room: nil, room_id: nil, reservation_id: reservation_id)
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
      reservation_id = Hotel::RoomManager.new.reservations.length + 1
      @reservation_id = reservation_id
    end

    def cost
      num_nights = @check_out_date - @check_in_date
      return 200.0 * num_nights
    end

    def self.load_all
      @reservations = []
    end

    # def connect(room)
    #   @room = room
    #   room.add_reservation(self)
    # end
  end
end
