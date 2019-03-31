require_relative "reservations_blocks_template"

module Hotel
  class ReservationManager < RandBTemplate
    attr_reader :reservations

    def initialize
      @reservations = []
      activity(@reservations)
    end

    def create_reservation(start_date, end_date, room, status: nil, block_id: nil, discount: nil)
      validate_date_range(start_date, end_date)
      room = validate_room_availability(start_date, end_date, room)

      if block_id != nil || status == nil
        reservation_id = block_id
        status = "B"
      elsif block_id != nil || status == "B"
        reservation = find_by_id(reservation_id)
        reservation_id = reservation
      end

      if block_id == nil
        reservation_id = @reservations.length + 1
        status = "R"
      else
        reservation_id = block_id
        status = "B"
      end
      new_reservation = Reservation.new(start_date, end_date, room, status: status, reservation_id: reservation_id, block_id: block_id, discount: discount)
      @reservations << new_reservation
      return new_reservation
    end

    def create_block(start_date, end_date, room, block_id: nil, discount: nil)
      if block_id != nil
        if room.length <= 5
          room.each do |room|
            create_reservation(start_date, end_date, room, block_id: block_id, discount: discount)
          end
        else
          raise ArgumentError, "The block can have up to 5 rooms"
        end
      end
      return true
    end

    def reserve_from_block(id)
      location = find_by_id(id: id)
      reservation_block = @reservations[location]
      reservation_block.status = "R"
      reservation_block.reservation_id = location + 1
      return reservation_block.reservation_id
    end

    def find_by_id(id:)
      index = 0
      if id.class == Integer
        @reservations.find do |reservation|
          if reservation.reservation_id == id
            return reservation
          end
        end
        raise ArgumentError, "Invalid reservation id"
      elsif id.class == String
        @reservations.each_with_index do |reservation, index|
          if reservation.reservation_id == id
            return index
          end
        end
        raise ArgumentError, "The block is empty"
      end
    end

    def available_rooms(reserved_rooms)
      available_rooms = rooms
      available_rooms -= reserved_rooms
      return available_rooms
    end
  end
end
