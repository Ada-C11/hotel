require "pry"
require "date"
# require_relative "reservation_manager"

module Hotel
  class Reservation
    attr_reader :reservation_id, :room, :room_id, :check_in_date, :check_out_date

    def initialize(reservation_id:,
                   room: nil,
                   room_id: nil,
                   check_in_date: "2019-12-25",
                   check_out_date: "2019-12-30")
      @reservation_id = reservation_id
      if room
        @room = room
        @room_id = room.room_id
      elsif room_id
        @room_id = room_id
      else
        raise ArgumentError, "room or room_id is required"
      end

      @check_in_date = Date.parse(check_in_date)
      # @check_in_date = Date.parse(check_in_date)
      @check_out_date = Date.parse(check_out_date)
      # @check_out_date = Date.parse(check_out_date)
      # Hotel::ReservationManager.validate_date_range(check_in_date, check_out_date)
      # @reservation_id = Hotel::ReservationManager.new.reservations.length + 1
    end

    # def reservation_id
    #   return Hotel::ReservationManager.new.reservations.length + 1
    # end

    def cost
      num_nights = @check_out_date - @check_in_date
      return Room.default_cost * num_nights
    end

    def self.load_all
      # @reservations = []
      return @reservations || []
    end
  end
end

# p Hotel::Reservation.new(reservation_id: 1, room_id: 1, check_in_date: "2019-12-25", check_out_date: "2019-12-30")
