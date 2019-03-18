require_relative "reservations_blocks_template"

module Hotel
  class ReservationManager < RandBTemplate
    attr_reader :reservations

    def initialize
      @reservations = []
      activity(@reservations)
    end

    def create_reservation(start_date, end_date, room_selected)
      validate_date_range(start_date, end_date)
      room = validate_room_availability(start_date, end_date, room_selected)
      id = @reservations.length + 1
      new_reservation = Reservation.new(id, start_date, end_date, room)
      @reservations << new_reservation
      return new_reservation
    end

    def find_by_id(id:)
      index = 0
      if id.class == Integer
        @reservations.find do |reservation|
          if reservation.id == id
            return reservation
          end
        end
        raise ArgumentError, "Invalid reservation id"
      end
    end

    def available_rooms(reserved_rooms)
      available_rooms = rooms
      available_rooms -= reserved_rooms
      return available_rooms
    end
  end
end
