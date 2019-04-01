require "date"

module HotelModel
  class HotelError < StandardError; end

  class Hotel
    attr_reader :reservations

    def initialize
      @rooms = (1..20).to_a
      @reservations = []
    end

    def list_rooms
      return @rooms
    end

    def add_reservation(new_reservation)
      raise HotelError.new("This reservation is in conflict with existing reservations.") if @reservations.any? do |reservation|
        new_reservation.conflicts_with?(reservation)
      end
      @reservations << new_reservation
    end

    def list_reservations_by_date_range(start_range, end_range)
      start_range = Date.parse(start_range)
      end_range = Date.parse(end_range)

      reservation_by_date = @reservations.select do |reservation|
        reservation.overlaps_with?(start_range, end_range)
      end
      return reservation_by_date
    end

    def list_available_rooms(start_range, end_range)
      start_range = Date.parse(start_range)
      end_range = Date.parse(end_range)

      available_rooms = (1..20).to_a

      @reservations.each do |reservation|
        if reservation.overlaps_with?(start_range, end_range)
          available_rooms.delete(reservation.room_number)
        end
      end
      return available_rooms
    end
  end
end
